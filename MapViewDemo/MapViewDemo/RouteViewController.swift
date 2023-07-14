//
//  RouteViewController.swift
//  MapViewDemo
//
//  Created by james on 31/05/2023.
//

import UIKit
import MapKit

class RouteViewController: UIViewController {
    @IBOutlet weak var routeMapView: MKMapView!
    
    var destination: MKMapItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        routeMapView.delegate = self
        routeMapView.showsUserLocation = true
    }
    
    private func getDirections() {
        let dirRequest = MKDirections.Request()
        dirRequest.source = MKMapItem.forCurrentLocation()
        dirRequest.destination = destination
        dirRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: dirRequest)
        
        directions.calculate { [weak self] response, error in
            if let route = response?.routes.first {
                self?.showRoute(route)
            } else {
                print("Couldn't get any routing response")
            }
        }
    }
    
    private func showRoute(_ route: MKRoute) {
        routeMapView.addOverlay(route.polyline, level: .aboveRoads)
        routeMapView.setVisibleMapRect(route.polyline.boundingMapRect,
                                       edgePadding: .init(top: 100, left: 100, bottom: 100, right: 100),
                                       animated: true)
        
        route.steps.forEach { step in
            print(step.instructions)
        }
    }
    
}

extension RouteViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let coord = userLocation.location?.coordinate {
            routeMapView.setCenter(coord, animated: true)
            
            getDirections()
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor.systemTeal
        renderer.lineWidth = 3
        
        return renderer
    }
}
