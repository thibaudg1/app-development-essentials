//
//  ViewController.swift
//  MapViewDemo
//
//  Created by james on 30/05/2023.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var searchText: UITextField!
    
    var matchingItems = [MKMapItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        mapView.showsUserLocation = true
        mapView.delegate = self
    }

    @IBAction func zoomIn(_ sender: Any) {
        if let userCoord = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegion(center: userCoord, latitudinalMeters: 2000, longitudinalMeters: 2000)
            
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func changeMapType(_ sender: Any) {
        if mapView.mapType == MKMapType.standard {
            mapView.mapType = MKMapType.satellite
        } else {
            mapView.mapType = MKMapType.standard
        }
    }
    
    @IBAction func textFieldReturn(_ sender: UITextField) {
        sender.resignFirstResponder()
        mapView.removeAnnotations(mapView.annotations)
        performSearch()
    }
    
    
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ResultsTableViewController
        destination.results = matchingItems
    }
}

extension ViewController {
    func performSearch() {
        matchingItems.removeAll(keepingCapacity: true)
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText.text
        request.region = mapView.region
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            if let results = response?.mapItems {
                print("\(results.count) matches")
                self?.matchingItems = results
                
                results.forEach { mapItem in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = mapItem.placemark.coordinate
                    annotation.title = mapItem.name
                    annotation.subtitle = mapItem.phoneNumber
                    
                    self?.mapView.addAnnotation(annotation)
                }
                
                self?.mapView.setRegion(response!.boundingRegion, animated: true)
                
            } else {
                print("No result for the local search")
            }
        }
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if let coord = userLocation.location?.coordinate {
            mapView.setCenter(coord, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = annotation is MKClusterAnnotation ? "cluster" : "marker"
        let clusterId: String? = annotation is MKClusterAnnotation ? nil : "marker"
        
        var view: MKMarkerAnnotationView
        
        if let dequeuedMarker = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKMarkerAnnotationView {
            dequeuedMarker.annotation = annotation
            dequeuedMarker.clusteringIdentifier = clusterId
            
            dequeuedMarker.markerTintColor = UIColor.systemTeal
            //view.glyphText = "Here"
            dequeuedMarker.glyphImage = UIImage(named: "small-business-20")
            dequeuedMarker.selectedGlyphImage = UIImage(named: "small-business-40")
            
            dequeuedMarker.canShowCallout = true
            dequeuedMarker.calloutOffset = CGPoint(x: -5, y: 5)
            dequeuedMarker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            view = dequeuedMarker
            
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            view.clusteringIdentifier = clusterId
            
            view.markerTintColor = UIColor.systemTeal
            //view.glyphText = "Here"
            view.glyphImage = UIImage(named: "small-business-20")
            view.selectedGlyphImage = UIImage(named: "small-business-40")
            
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let title = view.annotation?.title,
           let titleReally = title {
            print("More information for \(titleReally)?")
        }
    }
    
}

