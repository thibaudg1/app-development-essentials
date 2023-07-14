//
//  ViewController.swift
//  RecognizingGestures
//
//  Created by james on 23/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gesture: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapDetected(_ sender: UITapGestureRecognizer) {
        let state = sender.state
        print(state.rawValue)
        gesture.text = "Double tap - \(state)"
        
    }
    
    @IBAction func pinchDetected(_ sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        let velocity = sender.velocity
        
        let resultString = "Pinch - scale = \(scale), velocity = \(velocity)"
        
        gesture.text = resultString
    }
    
    @IBAction func rotationDetected(_ sender: UIRotationGestureRecognizer) {
        let angle = sender.rotation
        let velocity = sender.velocity
        
        let resultString = "Rotation - angle = \(angle) rad, velocity = \(velocity)"
        
        gesture.text = resultString
    }
    
    @IBAction func swipeDetected(_ sender: UISwipeGestureRecognizer) {
        let direction = sender.direction
        gesture.text = "Swipe: \(direction)"
    }
    
    @IBAction func longPressDetected(_ sender: UILongPressGestureRecognizer) {
        let state = sender.state
        print(state.rawValue)
        
        gesture.text = "Long press"
    }
}

