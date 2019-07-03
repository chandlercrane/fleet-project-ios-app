//
//  DataFlow.swift
//  demo
//
//  Created by sn032p on 2/7/19.
//  Copyright © 2019 Mapbox. All rights reserved.
//

import Foundation
import MapboxVision
import MapboxVisionAR
import MapboxVisionSafety
import CoreLocation

final class DataFlow {
    
    private var oAuthToken = ""
    
    init(){
        
        oAuthToken = authenticate()
    }
    struct TokenResponse: Decodable {
        var identity: String
        var token: String
    }
    
    
    func authenticate()-> String
    {
        
        let headers = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            "cache-control": "no-cache",
            
            ]
        let parameters = [
            "client_id": "ab9daf80-9d08-11e9-b48e-7bfb087df2d4",
            "client_secret": "ZbZHVASc1OD7ussxsBdgBEw60maVI034"
            ] as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.dataflow.iot.att.com/v1/oauth2/token")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        var token = ""
        
        let session = URLSession.shared
        let semaphore = DispatchSemaphore(value: 0)
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let json = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                token = json!["access_token"] as! String
                print ("token is: ",token)
                semaphore.signal()
            }
            
        })
        
        //return HTTPURLResponse
        dataTask.resume()
        semaphore.wait()
        return token
        
    }
    // changed POSITION to CLLOCATION
    func sendData( speedLimit: SpeedLimits?, position: CLLocation?){
        
        print("======SEND DATA BEGIN=======")

        
        let date = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)  // this is only available effective iOS 11 and macOS 10.13
        let formattedDate = formatter.string(from: date)
        //print ("vehicle speed", position?.speed, "SpeedLimit", speedLimit?.speedLimitRange.max,"longitude", position?.coordinate.longitude,"latitude",position?.coordinate.latitude)
        if (oAuthToken.count < 2)
        {
            print ("oauth token ..",oAuthToken)
            oAuthToken = self.authenticate()
        }
        let headers = [
            //"Authorization": "Bearer " + oAuthToken,
            "Content-Type": "application/json",
            "accept": "application/json",
            "cache-control": "no-cache",
        ]
        
        let parameters = [
            "timestamp": formattedDate,
            "class": "driver",
            "object": "cc304s",
            "data": [
                "speed": position?.speed,
                "speedLimit": speedLimit?.speedLimitRange.max,
                "distanceFront": 0,
                "location" : [
                    "longitude": position?.coordinate.longitude,
                    "latitude": position?.coordinate.latitude
                ]
            ]
        ]
        as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        let DFEndpoint: String = "https://api.dataflow.iot.att.com/v1/messages/cc304s/fleet-manager~dev/input"

        // "https://runm-west.dataflow.iot.att.com/bd6ee37747ad9/34448b55fb6a/9293d3bc8955f8a/in/flow/driver-input"
        let request = NSMutableURLRequest(url: NSURL(string: DFEndpoint)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                //print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                //print(httpResponse)
            }
        })
        
        dataTask.resume()
        
    }
    
    func sendDataSpeed(currentSpeed: Float, speedLimit: Float, longitude: Double, latitude: Double){
        print("======SEND DATA SPEED BEGIN=======")
        
        let date = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)  // this is only available effective iOS 11 and macOS 10.13
        let formattedDate = formatter.string(from: date)
        
        print("speed (m/s): ", currentSpeed)
        let currentSpeed_imp = currentSpeed * 2.23694
        print("speed (mph): ", currentSpeed_imp)
    
        print("speed limit (m/s): ", speedLimit)
        let speedLimit_imp : Int = Int((speedLimit * 2.23694).rounded())
        print("speed limit (mph): ", speedLimit_imp)
        
        if (oAuthToken.count < 2)
        {
            print ("oauth token ..",oAuthToken)
            oAuthToken = self.authenticate()
        }
        
        let headers = [
            //"Authorization": "Bearer " + oAuthToken,
            "Content-Type": "application/json",
            "accept": "application/json",
            "cache-control": "no-cache",
        ]
        let parameters = [
            "timestamp": formattedDate,
            "class": "speedData",
            "object": "speed-data-1",
            "data": [
                "speed" : currentSpeed_imp,
                "speedMetric" : currentSpeed,
                "speedLimit" : speedLimit_imp,
                "speedLimitMetric" : speedLimit,
                "location" : [
                    "longitude": longitude,
                    "latitude": latitude
                ],
            ]
            ]
            as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let DFEndpoint: String = "https://runm-west.dataflow.iot.att.com/2c8698709cb14/710ea56e7d52/fb9519d4873e025/in/flow/speedData-input"
        let request = NSMutableURLRequest(url: NSURL(string: DFEndpoint)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("=======ERROR=======")
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("=====RESPONSE=====")
                print(httpResponse)
            }
        })
        
        dataTask.resume()
        

    }
    func sendDataLocAndSign(signName:String, isSchoolZone: Bool, longitude: Double, latitude: Double, speedMetric: Double)
    {
        
        print("======SEND DATA LOC AND SIGN BEGIN=======")

        
        let date = Date()
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions.insert(.withFractionalSeconds)  // this is only available effective iOS 11 and macOS 10.13
        let formattedDate = formatter.string(from: date)
        print ("signName: ", signName)
        print("type of longitude: ", type(of: longitude))
        print ("longitude: ", longitude)
        print("type of latitude: ", type(of: latitude))
        print ("latitude: ", latitude)
        
        let speed = speedMetric * 2.23694
        
        
        
        if (oAuthToken.count < 2)
        {
            print ("oauth token ..",oAuthToken)
            oAuthToken = self.authenticate()
        }
        
        let headers = [
            //"Authorization": "Bearer " + oAuthToken,
            "Content-Type": "application/json",
            "accept": "application/json",
            "cache-control": "no-cache",
        ]
        let parameters = [
            "timestamp": formattedDate,
            "class": "trafficData",
            "object": "traffic-data-1",
            "data": [
                "sign": signName,
                "school-zone": isSchoolZone,
                "location" : [
                    "longitude": longitude,
                    "latitude": latitude
                ],
                "speed": speed,
                "speedMetric": speedMetric
            ]
        ]
        as [String : Any]
        
        let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        var DFEndpoint: String = "https://runm-west.dataflow.iot.att.com/a6fcb83d75b2d/819d2bf72ccb/fb01cb4efae1048/in/flow/trafficData-input"
        let request = NSMutableURLRequest(url: NSURL(string: DFEndpoint)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("=======ERROR=======")
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("=====RESPONSE=====")
                print(httpResponse)
            }
        })
        
        dataTask.resume()
        
    }
    
}


