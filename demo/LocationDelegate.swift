//
//  LocationDelegate.swift
//  demo
//
//  Created by CHANDLER CRANE on 7/2/19.
//  Copyright © 2019 Mapbox. All rights reserved.
//

import Foundation
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate{
    var last:CLLocation?
    override init(){
        self.currentSpeed = 0
        super.init()
    }
    
    var currentSpeed : Double
    
    func processLocation(_ current: CLLocation){
        guard last != nil else{
            last = current
            return
        }
        var speed = current.speed
        if(speed > 0){
            print("current speed from class test 3: ", speed)
            currentSpeed = speed
        }
        else{
            speed = last!.distance(from: current) / (current.timestamp.timeIntervalSince(last!.timestamp))
            print("current speed from class but distance calculated test 3: ", speed)
            currentSpeed = speed
        }
        last = current
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        for location in locations{
            processLocation(location)
        }
    }
}

