//
//  LocationManager.swift
//
//  Created by Ahmed Madeh.
//


import CoreLocation


//class LocationManager: NSObject {
//    typealias AuthorizationStatusCompletion = (_ status: CLAuthorizationStatus) -> Void
//    typealias Completion = (_ location: CLLocation?, _ error: Error?) -> Void
//
//    static let shared = LocationManager()
//    fileprivate var locationManager = CLLocationManager()
//    fileprivate var completion: AuthorizationStatusCompletion?
//    fileprivate var _completion: Completion?
//    var currentLocation: CLLocation? {
//        return locationManager.location
//    }
//
//    private override init() {
//        super.init()
//        setup()
//    }
//
//    private func setup() {
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    @discardableResult
//    fileprivate func startUpdatingLocation() -> Error? {
//        if !LocationManager.locationServicesEnabled {
//            return NSError.init(error: "Location services are not enabled", code: -1)
//        }
//        if LocationManager.authorizationStatus != .authorizedAlways && LocationManager.authorizationStatus != .authorizedWhenInUse {
//            return NSError.init(error: "Location access denied", code: -1)
//        }
//        locationManager.startUpdatingLocation()
//        return .none
//    }
//
//    func requestCurrentLocation(completion: @escaping Completion){
//        self._completion = completion
//        locationManager.requestAlwaysAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//    fileprivate func requestWhenInUseAuthorization(completion: AuthorizationStatusCompletion? = nil) {
//        self.completion = completion
//        locationManager.requestAlwaysAuthorization()
//    }
//
//    func stopUpdatingLocation() {
//        locationManager.stopUpdatingLocation()
//    }
//}
//extension LocationManager {
//   static var authorizationStatus: CLAuthorizationStatus {
//        return CLLocationManager.authorizationStatus()
//    }
// static var locationServicesEnabled: Bool {
//        return CLLocationManager.locationServicesEnabled()
//    }
//}
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self._completion?(locations.last, nil)
//        manager.stopUpdatingLocation()
//    }
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.completion?(status)
//    }
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        self._completion?(nil, error)
//        manager.stopUpdatingLocation()
//    }
//}
