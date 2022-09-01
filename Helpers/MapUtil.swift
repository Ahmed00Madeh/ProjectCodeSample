
//
//
//  MapUtil.swift
//
//  Created by Ahmed Madeh.
//

import UIKit
import MapKit
typealias AddressCompletion = (_ address:String?,_ error: Error?) -> Void

final class MapUtil {
    static var isGoogleMapSupporting: Bool {
        return UIApplication.shared.canOpenURL( URL.init(string: "comgooglemaps://")!)
    }
    
    class func drawRoad(form:CLLocation , to:CLLocation,completionHandler: @escaping MapKit.MKDirections.DirectionsHandler)   {
        
        let source = MKMapItem( placemark: MKPlacemark(
            coordinate: form.coordinate,
            addressDictionary: nil))
        let destination = MKMapItem(placemark: MKPlacemark(
            coordinate: to.coordinate,
            addressDictionary: nil))
        
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = source
        directionsRequest.destination = destination
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate { (response, error) -> Void in
            completionHandler(response,error)
        }
    }
    
    class func requestAddressFrom(location : CLLocation,completion : @escaping AddressCompletion) {
        
        
        CLGeocoder().reverseGeocodeLocation(location, preferredLocale: .init(identifier: Language.currentLanguage.rawValue)) { (placeMarks, error) in
            guard let last = placeMarks?.last else {
                return completion("Unidentified address", error)
            }
            let components: [String] = [last.locality, last.subAdministrativeArea, last.administrativeArea].compactMap{$0}
            completion(components.joined(separator: ", "), error)
            return
        }
    }
    
    class func getCoordinate( addressString : String,
                        completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
    
    private static func openAppleMap(lat: Double, long: Double, target: String = "") {
        let latitude: CLLocationDegrees = lat
        let longitude: CLLocationDegrees = long
        
        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = target
        mapItem.openInMaps(launchOptions: options)
    }
    
   private static func openGoogleMap(lat: Double, long: Double) {
        UIApplication.shared.open(URL(string: "comgooglemaps://?saddr=&daddr=\(lat),\(long)&directionsmode=driving")!, options: [:], completionHandler: nil)
    }
    class func visit(lat: Double, long: Double, target: String = "") {
        if !isGoogleMapSupporting {
            openAppleMap(lat: lat, long: long, target: target)
            return
        }
        ActionSheet.show(title: "Source", cancelTitle: "Cancel", otherTitles: ["Apple Maps", "Google Maps"], sender: UIView()) { (index) in
            if index == 1 {
                openAppleMap(lat: lat, long: long, target: target)
            } else if index == 2 {
                openGoogleMap(lat: lat, long: long)
            }
        }
    }
    
    static func requestScreenShot(at location: CLLocation, width: Int = 512, height: Int = 512, completion: @escaping MKMapSnapshotter.CompletionHandler) {
        let options = MKMapSnapshotter.Options()
        options.region = .init(center: location.coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        options.size = .init(width: width, height: height)
        MKMapSnapshotter(options: options).start(completionHandler: completion)
    }
}


