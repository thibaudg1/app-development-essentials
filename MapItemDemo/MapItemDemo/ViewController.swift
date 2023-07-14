//
//  ViewController.swift
//  MapItemDemo
//
//  Created by james on 30/05/2023.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var street: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var country: UITextField!
    
    var options: [String : Any]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showInMaps(_ sender: Any) {
        options = nil
        getPlacemarks()
    }
    
    @IBAction func getDirectionsTo(_ sender: Any) {
        options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        getPlacemarks()
    }
}

private extension ViewController {
    func getPlacemarks() {
        let street = street.text ?? ""
        let city = city.text ?? ""
        let state = state.text ?? ""
        let zip = zip.text ?? ""
        let country = country.text ?? ""
        
        let address = "\(street) \(city) \(state) \(zip) \(country)"
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            if let placemark = placemarks?.first {
                print("We received \(placemarks!.count) geocoded placemarks")
                self?.handlePlacemark(placemark)
                
            } else {
                print("We did not receive any geocoded placemarks")
            }
        }
    }
    
    func handlePlacemark(_ placemark: CLPlacemark) {
        let place = MKPlacemark(placemark: placemark)
        let mapItem = MKMapItem(placemark: place)
        
        if mapItem.openInMaps(launchOptions: options) {
            print("Launched Apple Maps successfully")
        } else { print("Failed to launch Apple Maps") }
    }
}
