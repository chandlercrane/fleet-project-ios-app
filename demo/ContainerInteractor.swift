//
//  ContainerInteractor.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision
import MapboxVisionAR
import MapboxVisionSafety
import CoreMedia
import CoreLocation

enum Screen {
    case menu
    case signsDetection
    case segmentation
    case objectDetection
    case distanceToObject
    case map
    case laneDetection
    case arRouting
}

protocol CalibrationProgress {
    var isCalibrated: Bool { get }
    var calibrationProgress: Float { get }
}

extension Camera: CalibrationProgress {}

protocol ContainerPresenter: class {
    func presentVision()
    func present(screen: Screen)
    func presentBackButton(isVisible: Bool)
    
    func present(frame: CMSampleBuffer)
    func present(segmentation: FrameSegmentation)
    func present(detections: FrameDetections)
    
    func present(signs: [ImageAsset])
    func present(roadDescription: RoadDescription?)
    func present(safetyState: SafetyState)
    func present(calibrationProgress: CalibrationProgress?)
    func present(speedLimit: ImageAsset?, isNew: Bool)
    
    func present(camera: ARCamera)
    func present(lane: ARLane?)
    
    func dismissCurrent()
}

protocol MenuDelegate: class {
    func selected(screen: Screen)
}

@objc protocol ContainerDelegate: class {
    func backButtonPressed()
    func didNavigationRouteUpdated(route: MapboxVisionAR.Route?)
}

private let signTrackerMaxCapacity = 5
private let collisionAlertDelay: TimeInterval = 3
private let speedLimitAlertDelay: TimeInterval = 5

final class ContainerInteractor {
    
    private var oAuthToken = ""
    private struct SpeedLimitState: Equatable {
        let speedLimits: SpeedLimits
        let isSpeeding: Bool
    }
    
    private class AutoResetRestriction {
        var isAllowed: Bool = true
        
        private let resetInterval: TimeInterval
        
        private var timer: Timer?
        
        init(resetInterval: TimeInterval) {
            self.resetInterval = resetInterval
        }
        
        func restrict() {
            isAllowed = false
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: resetInterval, repeats: false) { [weak self] _ in
                self?.isAllowed = true
            }
        }
    }
    
    private var currentScreen = Screen.menu
    private let presenter: ContainerPresenter
    private let visionManager: VisionManagerProtocol
    
    
    private var visionARManager: VisionARManager?
    private var visionSafetyManager: VisionSafetyManager?
    private let camera: VideoSource
    
    private lazy var delegateProxy = DelegateProxy(delegate: self)
    
    private let signTracker = Tracker<Sign>(maxCapacity: signTrackerMaxCapacity)
    private var signTrackerUpdateTimer: Timer?
    
    private let alertPlayer: AlertPlayer
    private var lastSafetyState = SafetyState.none
    private var lastSpeedLimitState: SpeedLimitState?
    
    /*------------------------------------
    ----------DATA FLOW INSTANCE----------
    ------------------------------------*/
    private var dataFlow = DataFlow()
    
    private var speedLimitAlertRestriction = AutoResetRestriction(resetInterval: speedLimitAlertDelay)
    private var collisionAlertRestriction = AutoResetRestriction(resetInterval: collisionAlertDelay)
    
    //vision values caching
    private var calibrationProgress: CalibrationProgress?
    
    private var speedLimits: SpeedLimits?
    private var currentSpeed: Float?
    private var currentCountry: Country = .unknown
    
    private var currentSpeedLimit: Float?
    
    struct Dependencies {
        let alertPlayer: AlertPlayer
        let presenter: ContainerPresenter
    }
    
    init(dependencies: Dependencies) {
        self.presenter = dependencies.presenter
        self.alertPlayer = dependencies.alertPlayer
        
        let camera = CameraVideoSource()
        camera.start()
        let visionManager = VisionManager.create(videoSource: camera)

        self.camera = camera
        self.visionManager = visionManager

        visionARManager = VisionARManager.create(visionManager: visionManager, delegate: delegateProxy)
        visionSafetyManager = VisionSafetyManager.create(visionManager: visionManager, delegate: delegateProxy)

        camera.add(observer: self)
        visionManager.start(delegate: delegateProxy)

        presenter.presentVision()
        present(screen: .menu)
    }
    
    private func scheduleSignTrackerUpdates() {
        stopSignTrackerUpdates()
        
        signTrackerUpdateTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let `self` = self else { return }
            let signs = self.signTracker.getCurrent().compactMap { self.getIcon(for: $0, over: false) }
            
            // START DATA FLOW ADDITION
            
            var locManager = CLLocationManager()
            //locManager.requestWhenInUseAuthorization()
            var currentLocation: CLLocation!
            
            if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways){
                currentLocation = locManager.location
            }
            var del = LocationDelegate()
            var lm = CLLocationManager()
            lm.delegate = del
            lm.startUpdatingLocation()
            
            let speedLimit : Int = Int(self.speedLimits?.speedLimitRange.max ?? 0 * 2.237)
            
            var isSchoolZone : Bool = false
            for sign in signs{
                if(sign.name == "Warning_School_Zone_US"){
                    isSchoolZone = true
                }
            }
            for sign in signs{
                if(sign.name == "Regulatory_End_Of_School_Zone_US"){
                    isSchoolZone = false
                }
            }
            
            if (signs.count > 0){
                /*-----------------------
                 -----DATA FLOW SEND------
                 -----------------------*/
                
                for sign in signs{
                    self.dataFlow.sendDataLocAndSign(signName: sign.name, isSchoolZone: isSchoolZone, longitude: currentLocation.coordinate.longitude, latitude: currentLocation.coordinate.latitude)

                }
            }
            
            // END DATA FLOW ADDITION
            
            self.presenter.present(signs: signs)
        }
    }
    
    private func stopSignTrackerUpdates() {
        signTrackerUpdateTimer?.invalidate()
        signTracker.reset()
    }
    
    private func modelPerformanceConfig(for screen: Screen) -> ModelPerformanceConfig {
        switch screen {
        case .signsDetection, .objectDetection:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .high))
        case .segmentation:
            return .separate(segmentationPerformance: ModelPerformance(mode: .fixed, rate: .high),
                             detectionPerformance: ModelPerformance(mode: .fixed, rate: .low))
        case .distanceToObject, .laneDetection:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .medium))
        case .map, .menu, .arRouting:
            return .merged(performance: ModelPerformance(mode: .fixed, rate: .low))
        }
    }
    
    private func resetPresentation() {
        stopSignTrackerUpdates()
        alertPlayer.stop()
        presenter.present(signs: [])
        presenter.present(roadDescription: nil)
        presenter.present(safetyState: .none)
        presenter.present(calibrationProgress: nil)
        presenter.present(speedLimit: nil, isNew: false)
    }
    
    private func present(screen: Screen) {
        presenter.dismissCurrent()
        visionManager.modelPerformanceConfig = modelPerformanceConfig(for: screen)
        presenter.present(screen: screen)
        presenter.presentBackButton(isVisible: screen != .menu)
        currentScreen = screen
    }
    
    // START DATA FLOW ADDITION
    // changed POSITION to CLLOCATION
    private func check(_ speedLimit: SpeedLimits, at position: CLLocation?) -> Bool {
        guard let position = position else { return false }
        return position.speed > Double(speedLimit.speedLimitRange.max)
    }
    // changed POSITION to CLLOCATION
    private func update(speedLimit: SpeedLimits?, position: CLLocation?) {
        guard
            case .distanceToObject = currentScreen,
            let speedLimit = speedLimit
            else {
                presenter.present(speedLimit: nil, isNew: false)
                lastSpeedLimitState = nil
                return
        }
        
        let isSpeeding = check(speedLimit, at: position)
        let newState = SpeedLimitState(speedLimits: speedLimit, isSpeeding: isSpeeding)
        
        guard newState != lastSpeedLimitState else { return }
        
        NSLog("Position speed is - %0.4f, speedlimit is %0.4f", position?.speed ?? -1 , Double(speedLimit.speedLimitRange.max))
        /*-----------------------
         -----DATA FLOW SEND------
         -----------------------*/
        
        print("======ABOUT TO SEND DATA...=======")

        dataFlow.sendData(speedLimit: speedLimit, position: position)
        
        presentSpeedLimit(oldState: lastSpeedLimitState, newState: newState)
        playSpeedLimitAlert(oldState: lastSpeedLimitState, newState: newState)
        
        lastSpeedLimitState = newState
    }
    
    // END DATA FLOW ADDITION
    
    private func updateSpeedLimits() {
        guard
            case .distanceToObject = currentScreen,
            let speedLimits = speedLimits,
            let speed = currentSpeed
        else {
            presenter.present(speedLimit: nil, isNew: false)
            lastSpeedLimitState = nil
            return
        }
        
        let isSpeeding = speed > speedLimits.speedLimitRange.max
        let newState = SpeedLimitState(speedLimits: speedLimits, isSpeeding: isSpeeding)

        guard newState != lastSpeedLimitState else { return }
        NSLog("Position speed is - %0.4f, speedlimit is %0.4f", speed, Double(speedLimits.speedLimitRange.max))
        //update(speedLimit: speedLimits, position: nil)
        
        presentSpeedLimit(oldState: lastSpeedLimitState, newState: newState)
        playSpeedLimitAlert(oldState: lastSpeedLimitState, newState: newState)

        lastSpeedLimitState = newState
    }
    
    private func presentSpeedLimit(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        print("present speed limit function")
        let sign = getIcon(for: Sign(type: .speedLimit, number: newState.speedLimits.speedLimitRange.max), over: newState.isSpeeding)
        let isNew = oldState == nil || oldState!.speedLimits != newState.speedLimits
        presenter.present(speedLimit: sign, isNew: isNew)
        //print("current speed: ", self.currentSpeed)
        //print("speed limit: ", newState.speedLimits.speedLimitRange.max)
    }
    
    private func playSpeedLimitAlert(oldState: SpeedLimitState?, newState: SpeedLimitState) {
        let wasSpeeding = oldState?.isSpeeding ?? false
        let hasStartedSpeeding = newState.isSpeeding && !wasSpeeding
        
        if hasStartedSpeeding, speedLimitAlertRestriction.isAllowed {
            alertPlayer.play(sound: .overSpeedLimit, repeated: false)
            speedLimitAlertRestriction.restrict()
        }
    }
    
    private func getIcon(for sign: Sign, over: Bool) -> ImageAsset? {
        return sign.icon(over: over, country: currentCountry)
    }
    
    deinit {
        camera.remove(observer: self)
    }
}

extension ContainerInteractor: ContainerDelegate {
    
    func backButtonPressed() {
        resetPresentation()
        present(screen: .menu)
    }
    
    func didNavigationRouteUpdated(route: MapboxVisionAR.Route?) {
        if let route = route {
            visionARManager?.set(route: route)
        }
    }
}

extension ContainerInteractor: MenuDelegate {
    
    func selected(screen: Screen) {
        switch screen {
        case .signsDetection:
            scheduleSignTrackerUpdates()
        case .distanceToObject:
            presenter.present(calibrationProgress: calibrationProgress)
        default: break
        }
        
        present(screen: screen)
    }
}

extension ContainerInteractor: VisionManagerDelegate {
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSegmentation frameSegmentation: FrameSegmentation) {
        guard case .segmentation = currentScreen else { return }
        presenter.present(segmentation: frameSegmentation)
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameDetections frameDetections: FrameDetections) {
        guard case .objectDetection = currentScreen else { return }
        presenter.present(detections: frameDetections)
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateFrameSignClassifications frameSignClassifications: FrameSignClassifications) {
        guard case .signsDetection = currentScreen else { return }
        let items = frameSignClassifications.signs.map({ $0.sign })
        signTracker.update(items)
        /*
        print("------start frame sign classification------")
        for item in items{
            print(item.type)
        }
        print("-------end frame sign classifcation-------")
        */
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateVehicleState vehicleState: VehicleState) {
        guard case .distanceToObject = currentScreen else { return }
        currentSpeed = vehicleState.speed
        print("updated vehicle state")
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateRoadDescription roadDescription: RoadDescription) {
        guard case .laneDetection = currentScreen else { return }
        presenter.present(roadDescription: roadDescription)
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCamera camera: Camera) {
        calibrationProgress = camera
        guard case .distanceToObject = currentScreen else { return }
        presenter.present(calibrationProgress: camera)
    }
    
    func visionManager(_ visionManager: VisionManagerProtocol, didUpdateCountry country: Country) {
        currentCountry = country
    }
    
    func visionManagerDidCompleteUpdate(_ visionManager: VisionManagerProtocol) {
        updateSpeedLimits()
    }
    // ADDED FROM SRINIVAS BUT DOES NOT WORK CURRENTLY
    
    func visionManager(_ visionManager: VisionManager, didUpdateEstimatedPosition estimatedPosition: CLLocation?) {
        // NSLog("In updated estimated position %0.6f, %0.6f", estimatedPosition?.clLocation.coordinate.latitude ?? 0,estimatedPosition?.clLocation.coordinate.longitude ?? 0)
        
        // print(estimatedPosition?.coordinate.longitude ??  0,estimatedPosition?.coordinate.latitude ?? 0)
        print("updated estimated position")
    }
    
}

extension ContainerInteractor: VideoSourceObserver {
    func videoSource(_ videoSource: VideoSource, didOutput videoSample: VideoSample) {
        DispatchQueue.main.async { [weak self] in
            self?.presenter.present(frame: videoSample.buffer)
        }
    }
}

extension ContainerInteractor: VisionARManagerDelegate {
    func visionARManager(_ visionARManager: VisionARManager, didUpdateARCamera camera: ARCamera) {
        presenter.present(camera: camera)
    }
    
    func visionARManager(_ visionARManager: VisionARManager, didUpdateARLane lane: ARLane?) {
        presenter.present(lane: lane)
    }
}

extension ContainerInteractor: VisionSafetyManagerDelegate {
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateRoadRestrictions roadRestrictions: RoadRestrictions) {
        speedLimits = roadRestrictions.speedLimits
        print("this is executing...")
        let locManager = CLLocationManager()
        locManager.distanceFilter = kCLDistanceFilterNone
        locManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        let currentLocation = locManager.location
        let currentHeading = locManager.heading
        
        //let currentElevation =
        let speedLimit_metric : Float = speedLimits!.speedLimitRange.max
        //let speedLimit : Int = Int(speedLimit_metric * 2.237)
        print("speed limit (m/s): ", speedLimit_metric)
        print("location: ", currentLocation)
        print("heading: ", currentHeading)
        
        let myCurrentSpeed = self.currentSpeed
        let currentSpeed : CLLocationSpeed = CLLocationSpeed()
        
        print("speed test 1: ", myCurrentSpeed)
        print("speed test 2: ", currentSpeed)
        
        self.currentSpeedLimit = speedLimit_metric
        self.dataFlow.sendDataSpeed(currentSpeed: Float(currentSpeed ?? 0), speedLimit: speedLimit_metric)
        //update(speedLimit: speedLimits, position: currentLocation)
    }
    
    func visionSafetyManager(_ visionSafetyManager: VisionSafetyManager, didUpdateCollisions collisions: [CollisionObject]) {
        guard case .distanceToObject = currentScreen else {
            presenter.present(safetyState: .none)
            return
        }
        
        let state = SafetyState(collisions)
            
        switch state {
        case .none: break
        case .collisions(let collisions):
            let containsPerson = collisions.contains { $0.objectType == .person && $0.state == .critical }
            if containsPerson, collisionAlertRestriction.isAllowed {
                alertPlayer.play(sound: .collisionAlertCritical, repeated: false)
                collisionAlertRestriction.restrict()
            }
        }
        
        presenter.present(safetyState: state)
    }
}

