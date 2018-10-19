//
//  ContainerViewController.swift
//  demo
//
//  Created by Maksim Vaniukevich on 7/7/18.
//  Copyright © 2018 Mapbox. All rights reserved.
//

import UIKit
import MapboxVision
import MapboxVisionAR
import MapboxNavigation

private let bannerInset: CGFloat = 18
private let roadLanesHeight: CGFloat = 64
private let smallRelativeInset: CGFloat = 16
private let buttonHeight: CGFloat = 36

final class ContainerViewController: UIViewController {
    
    weak var delegate: ContainerDelegate? {
        didSet {
            backButton.addTarget(delegate, action: #selector(ContainerDelegate.backButtonPressed), for: .touchUpInside)
        }
    }
    
    var visionViewController: VisionPresentationViewController?
    var menuViewController: MenuViewController?
    private lazy var arContainerViewController = ARContainerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 18),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            backButton.widthAnchor.constraint(lessThanOrEqualToConstant: 44),
            backButton.heightAnchor.constraint(lessThanOrEqualToConstant: 44)
        ])
        
        view.addSubview(roadLanesView)
        NSLayoutConstraint.activate([
            roadLanesView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roadLanesView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            roadLanesView.heightAnchor.constraint(equalToConstant: roadLanesHeight)
        ])
        
        view.addSubview(signsStack)
        NSLayoutConstraint.activate([
            signsStack.topAnchor.constraint(equalTo: view.topAnchor),
            signsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        view.addSubview(distanceView)
        view.addSubview(collisitonObjectView)
        
        view.addSubview(distanceLabel)
        NSLayoutConstraint.activate([
            distanceLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -smallRelativeInset),
            distanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            distanceLabel.heightAnchor.constraint(equalToConstant: buttonHeight),
        ])
        
        view.addSubview(collisionAlertView)
        NSLayoutConstraint.activate([
            collisionAlertView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            collisionAlertView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        view.addSubview(laneDepartureView)
        NSLayoutConstraint.activate([
            laneDepartureView.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            laneDepartureView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -bannerInset),
        ])
        
        view.addSubview(calibrationLabel)
        NSLayoutConstraint.activate([
            calibrationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: bannerInset),
            calibrationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func present(viewController: UIViewController) {
        super.present(viewController: viewController)
        view.insertSubview(viewController.view, belowSubview: backButton)
    }

    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Asset.Assets.back.image, for: .normal)
        return button
    }()
    
    private let roadLanesView: RoadLanesView = {
        let view = RoadLanesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let signsStack: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = smallRelativeInset
        view.alignment = .center
        view.axis = .horizontal
        view.isHidden = true
        return view
    }()
    
    private let distanceView: DistanceView = {
        let view = DistanceView(frame: .zero)
        view.backgroundColor = .clear
        view.isHidden = true
        return view
    }()
    
    private let distanceLabel: PaddedLabel = {
        let view = PaddedLabel.createDarkRounded()
        return view
    }()
    
    private let collisitonObjectView: CollisionObjectView = {
        let view = CollisionObjectView(frame: .zero)
        view.isHidden = true
        view.backgroundColor = .clear
        return view
    }()
    
    private let collisionAlertView: UIImageView = {
        let view = UIImageView(image: Asset.Assets.brake.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let laneDepartureView: UIImageView = {
        let view = UIImageView(image: Asset.Assets.laneDepartureNotification.image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    private let calibrationLabel: UILabel = {
        let label = PaddedLabel.createDarkRounded()
        return label
    }()
    
    private lazy var distanceFormatter: DistanceFormatter = {
        return DistanceFormatter(approximate: false)
    }()
    
    private weak var currentViewController: UIViewController?
}

extension ContainerViewController: ContainerPresenter {
    
    func present(signs: [ImageAsset]) {
        signsStack.subviews.forEach { $0.removeFromSuperview() }
        signsStack.isHidden = signs.isEmpty
        signs.map { UIImageView(image: $0.image) }.forEach(signsStack.addArrangedSubview)
    }
    
    func present(distanceToCar: DistanceToCar?, canvasSize: CGSize) {
        guard let distanceToCar = distanceToCar else {
            distanceView.isHidden = true
            distanceLabel.isHidden = true
            return
        }
        
        distanceView.isHidden = false
        distanceLabel.isHidden = false
        
        let left = distanceToCar.leftPosition.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        let right = distanceToCar.rightPosition.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        
        distanceView.update(left, right)
        distanceLabel.text = distanceFormatter.string(fromMeters: distanceToCar.distance)
    }
    
    func present(roadDescription: RoadDescription?) {
        guard let roadDescription = roadDescription else {
            roadLanesView.isHidden = true
            return
        }
        roadLanesView.isHidden = false
        roadLanesView.update(roadDescription)
    }
    
    func present(laneDepartureState: LaneDepartureState) {
        let isVisible: Bool
        
        switch laneDepartureState {
        case .normal, .warning:
            isVisible = false
        case .alert:
            isVisible = true
        }
        
        laneDepartureView.isHidden = !isVisible
    }
    
    func present(calibrationProgress: CalibrationProgress?) {
        calibrationLabel.isHidden = calibrationProgress?.isCalibrated ?? true
        guard let calibrationProgress = calibrationProgress else { return }
        calibrationLabel.text = L10n.generalCalibration(Int(ceil(calibrationProgress.progress * 100)))
    }
    
    func present(collisionObjectFrame: CGRect?, canvasSize: CGSize) {
        guard let frame = collisionObjectFrame else {
            collisitonObjectView.isHidden = true
            collisionAlertView.isHidden = true
            return
        }
        
        let leftTop = frame.origin.convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        let rightBottom = CGPoint(x: frame.maxX, y: frame.maxY).convertForAspectRatioFill(from: canvasSize, to: view.bounds.size)
        
        let rect = CGRect(x: leftTop.x, y: leftTop.y, width: rightBottom.x - leftTop.x, height: rightBottom.y - leftTop.y)
        let pct: CGFloat = 2.0
        let newWidth: CGFloat = sqrt(rect.width * rect.width * pct)
        let newHeight: CGFloat = sqrt(rect.height * rect.height * pct)
        let newRect = rect.insetBy(dx: (rect.width - newWidth) / 2, dy: (rect.height - newHeight) / 2)
        
        collisitonObjectView.isHidden = false
        collisionAlertView.isHidden = false
        collisitonObjectView.update(newRect)
    }
    
    func present(screen: Screen) {
        switch screen {
        case .signsDetection: visionViewController?.frameVisualizationMode = .clear
        case .segmentation: visionViewController?.frameVisualizationMode = .segmentation
        case .objectDetection: visionViewController?.frameVisualizationMode = .detection
        case .distanceToObject: visionViewController?.frameVisualizationMode = .clear
        case .map: presentMap()
        case .laneDetection: visionViewController?.frameVisualizationMode = .clear
        case .arRouting: presentARRouting()
        case .menu: presentMenu()
        }
    }
    
    func presentMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before presenting")
            return
        }
        present(viewController: viewController)
        visionViewController?.frameVisualizationMode = .clear
    }
    
    func presentVision() {
        guard let viewController = visionViewController else {
            assertionFailure("Vision should be initialized before presenting")
            return
        }
        
        present(viewController: viewController)
        viewController.frameVisualizationMode = .clear
    }
    
    private func presentMap() {
        let viewController = MapViewController()
        present(viewController: viewController)
        currentViewController = viewController
    }
    
    private func presentARRouting() {
        present(viewController: arContainerViewController)
        currentViewController = arContainerViewController
    }

    func presentBackButton(isVisible: Bool) {
        backButton.isHidden = !isVisible
    }
    
    func dismissMenu() {
        guard let viewController = menuViewController else {
            assertionFailure("Menu should be initialized before dismiss")
            return
        }
        dismiss(viewController: viewController)
    }
    
    func dismissCurrent() {
        guard let viewController = currentViewController else { return }
        dismiss(viewController: viewController)
        currentViewController = nil
    }
}

extension UIViewController {
    
    @objc func present(viewController: UIViewController) {
        addChildViewController(viewController)
        view.addSubview(viewController.view)
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        viewController.didMove(toParentViewController: self)
    }
    
    func dismiss(viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
}
