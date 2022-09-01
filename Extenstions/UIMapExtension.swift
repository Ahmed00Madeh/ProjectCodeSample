//
//  UIMapExtension.swift
//
//  Created by Ahmed Madeh
//

import UIKit
import MapKit

extension MKMapView {
    
    func zoomToLocation(location: CLLocation, level:Float = -1, animated: Bool = false) {
        
        let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: CLLocationDistance(level), longitudinalMeters: CLLocationDistance(level))
        
        let region = MKCoordinateRegion(center: location.coordinate,span: region.span)
        setRegion(level == -1 ? region : viewRegion , animated: animated)
    }
    
    func drawRouts(routs: [MKRoute]) {
        for route in routs {
            if !overlays(in: .aboveRoads).isEmpty {
                removeOverlays(overlays(in: .aboveRoads))
            }
            addOverlay(route.polyline, level:.aboveRoads)
        }
    }

    var isRegionChangedByUser: Bool {
        let view = subviews.first
        for recognizer in (view?.gestureRecognizers)! {
            if recognizer.state == .began ||
                recognizer.state == .ended ||
                recognizer.state == .failed {
                return true
            }
        }
        return false
    }
    
    
    func addAnnotation(lat: Double, long: Double, title: String) {
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        self.addAnnotation(annotation)
    }
    
}

extension MKPointAnnotation {
    convenience init(coordinate: CLLocationCoordinate2D) {
        self.init()
        self.coordinate = coordinate
    }
}

extension Array where Element: CLLocation {
    func midLocationFor(mapView: MKMapView) -> CLLocation {
        let midX = compactMap {mapView.convert($0.coordinate, toPointTo: mapView).x}.reduce(0, +) / CGFloat(count)
        let midY = compactMap {mapView.convert($0.coordinate, toPointTo: mapView).y}.reduce(0, +) / CGFloat(count)
        let coordinate = mapView.convert(CGPoint(x: midX, y: midY), toCoordinateFrom: mapView)
        return CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
    func containsPoint(point: CLLocation, forMapVew: MKMapView) -> Bool {
        guard self.count > 1 else { return false }
        let path = UIBezierPath()
        let firstPoint = forMapVew.convert(self.first!.coordinate, toPointTo: forMapVew)
        path.move(to: firstPoint)
        for index in 1...count-1 {
            let point = forMapVew.convert(self[index].coordinate, toPointTo: forMapVew)
            path.addLine(to: point)
        }
        path.close()
        return path.contains(forMapVew.convert(point.coordinate, toPointTo: forMapVew))
    }
}


