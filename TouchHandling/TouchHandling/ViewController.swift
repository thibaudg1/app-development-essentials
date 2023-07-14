//
//  ViewController.swift
//  TouchHandling
//
//  Created by james on 12/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var taps: UILabel!
    @IBOutlet weak var touches: UILabel!
    @IBOutlet weak var method: UILabel!    
    @IBOutlet weak var coordinates: UILabel!
    @IBOutlet weak var tapped: UILabel!
    
    var countBegan = 0
    var countMoved = 0
    var countEnded = 0
    var buttonTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        countBegan += 1
        
        let fingers = touches.count
        
        if let firstTouch = touches.first {
            let coordinate = firstTouch.location(in: self.view)
            let x = Int(coordinate.x)
            let y = Int(coordinate.y)
            
            coordinates.text = "X = \(x) ; Y = \(y)"
            
            let tapCount = firstTouch.tapCount
            
            method.text = "touchesBegan #\(countBegan)"
            self.touches.text = "\(fingers) touches"
            taps.text = "\(tapCount) taps"
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        countMoved += 1
        
        let fingers = touches.count
        
        if let firstTouch = touches.first {
            let coordinate = firstTouch.location(in: self.view)
            let x = Int(coordinate.x)
            let y = Int(coordinate.y)
            
            coordinates.text = "X = \(x) ; Y = \(y)"
            
            let tapCount = firstTouch.tapCount
            
            method.text = "touchesMoved #\(countMoved)"
            self.touches.text = "\(fingers) touches"
            taps.text = "\(tapCount) taps"
            
            if let event,
               let predicted = event.predictedTouches(for: firstTouch) {
                print("Current location: X = \(x) ; Y = \(y)")
                for predict in predicted {
                    let point = predict.location(in: self.view)
                    print("Predicted location: X = \(point.x), Y = \(point.y)")
                }
                
                print("===========")
            }
            
            if let event,
               let coalesced = event.coalescedTouches(for: firstTouch) {
                for coalesce in coalesced {
                    let interPoint = coalesce.location(in: self.view)
                    print("Coalesced location X = \(interPoint.x), Y = \(interPoint.y)")
                }
                
                print("+++++++++++")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        countEnded += 1
        
        let fingers = touches.count
        
        if let firstTouch = touches.first {
            let coordinate = firstTouch.location(in: self.view)
            let x = Int(coordinate.x)
            let y = Int(coordinate.y)
            
            coordinates.text = "X = \(x) ; Y = \(y)"
            
            let count = firstTouch.tapCount
            
            method.text = "touchesEnded #\(countEnded)"
            self.touches.text = "\(fingers) touches"
            taps.text = "\(count) taps"
        }
    }
    
    
    @IBAction func tapped(_ sender: Any) {
        buttonTapped += 1
        
        tapped.text = "Button tapped \(buttonTapped) times"
    }
    
}

