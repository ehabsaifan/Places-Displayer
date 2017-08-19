//
//  LocationManager.swift
//  Places Displayer
//
//  Created by Ehab Saifan on 8/19/17.
//  Copyright © 2017 Home. All rights reserved.
//

import UIKit
import MapKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static var currentManager = LocationManager()
    
    private let manager = CLLocationManager()
    var currentLocation : CLLocationCoordinate2D?
    
    var isEnabled : Bool {
        get {
            return CLLocationManager.locationServicesEnabled()
        }
    }
    
    override init() {
        super.init()
        // Do any additional setup after loading the view.
        self.manager.delegate = self
        self.manager.distanceFilter = 500
        self.manager.desiredAccuracy = kCLLocationAccuracyKilometer
    
        NotificationCenter.default.addObserver(forName: .UIApplicationDidBecomeActive, object: nil, queue: OperationQueue.main) { [weak self] not in
            self?.requestAccess()
            if self?.isEnabled == true {
                self?.startUpdateLocation()
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func startUpdateLocation(){
        self.manager.startUpdatingLocation()
    }
    
    private func endUpdateLocation(){
        //self.manager.stopUpdatingLocation()
    }
    
    func requestAccess(){
        if CLLocationManager.authorizationStatus() == .notDetermined {
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: location delegate
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            self.startUpdateLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //replace current location
        self.currentLocation = locations.last?.coordinate
    }


}
