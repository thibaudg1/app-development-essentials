//
//  ViewController.swift
//  AnimationDemo
//
//  Created by james on 30/05/2023.
//

import UIKit

class ViewController: UIViewController {
    var scaleFactor: CGFloat = 2
    var angle: CGFloat = 180
    var boxView: UIView?
    var animator: UIViewPropertyAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initBox()
    }

    func initBox() {
        boxView = UIView(frame: CGRect(x: 20, y: 20, width: 40, height: 40))
        boxView?.backgroundColor = UIColor.blue
        view.addSubview(boxView!)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstFinger = touches.first {
            //if another end touch is detected before current animation is finished:
            self.animator?.stopAnimation(false)
            self.animator?.finishAnimation(at: .current)
            
            let location = firstFinger.location(in: self.view)
            
            let timing = UICubicTimingParameters(animationCurve: .easeInOut)
            let timing2 = UISpringTimingParameters(mass: 0.5, stiffness: 0.5,
                                                   damping: 0.3, initialVelocity: CGVector(dx:1.0, dy: 0.0))
            
            let animator = UIViewPropertyAnimator(duration: 2,
                                                  timingParameters: scaleFactor == 2 ? timing : timing2)
            self.animator = animator
            
            animator.addAnimations { [boxView, scaleFactor, angle] in
                let scaleTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)
                let rotationTransform = CGAffineTransform(rotationAngle: angle / 180 * .pi)
                
                boxView?.transform = scaleTransform.concatenating(rotationTransform)
                boxView?.backgroundColor = UIColor.purple
                boxView?.center = location
            }
            
            animator.addCompletion { [self] position in
                boxView?.backgroundColor = UIColor.green
                
                angle = angle == 180 ? 360 : 180
                scaleFactor = scaleFactor == 2 ? 1 : 2
            }
            
            animator.startAnimation()
        }
    }
}

