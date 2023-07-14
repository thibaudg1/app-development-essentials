//
//  ViewController.swift
//  Signature1
//
//  Created by james on 28/05/2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var signatureInput: UIView!
    @IBOutlet weak var signatureOutput: ViewForDrawing!
    @IBOutlet weak var captureDrawView: CaptureAndDrawView!
    
    var newInput = [CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouches(touches)
        
        print("Sending \(newInput.count) touches for drawing")
        signatureOutput.drawCoordinates(newInput)
        
        newInput = []
    }
    
    func handleTouches(_ touches: Set<UITouch>) {
        let fingers = touches.count
        if fingers > 1 {
            print("\(fingers) fingers!")
        }
        
        if let firstFinger = touches.first {
            
            let locationInMainView = firstFinger.location(in: self.view)
            if signatureInput.frame.contains(locationInMainView) {
                print("Green box contains X: \(Int(locationInMainView.x)) - Y: \(Int(locationInMainView.y))")
                
                let localLocation = firstFinger.location(in: self.signatureInput)
                newInput.append(localLocation)
            } else if captureDrawView.frame.contains(locationInMainView) {
                print("Red box contains X: \(Int(locationInMainView.x)) - Y: \(Int(locationInMainView.y))")
                
                let localLocation = firstFinger.location(in: self.captureDrawView)
                newInput.append(localLocation)
            }
            
            
//            let location = firstFinger.location(in: firstFinger.view)
//
//            print("New green input at X:\(Int(location.x)) - Y:\(Int(location.y))")
//
//            newInput.append(location)
        }
    }
    
    @IBAction func clearCanva(_ sender: Any) {
        signatureOutput.eraseCanva()
        captureDrawView.eraseCanva()
    }
}

