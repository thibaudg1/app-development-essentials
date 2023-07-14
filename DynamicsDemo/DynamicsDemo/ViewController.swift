//
//  ViewController.swift
//  DynamicsDemo
//
//  Created by james on 30/05/2023.
//

import UIKit

class ViewController: UIViewController {
    var redBox: UIView!
    var blueBox: UIView!
    
    var animator: UIDynamicAnimator?
    var currentLocation = CGPoint()
    var attachment: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initAnim()
    }
    
    func initAnim() {
        redBox = UIView(frame: CGRect(x: 20, y: 100, width: 45, height: 55))
        redBox.backgroundColor = .red.withAlphaComponent(0.6)
        
        blueBox = UIView(frame: CGRect(x: 120, y: 300, width: 25, height: 30))
        blueBox.backgroundColor = .blue.withAlphaComponent(0.9)
        
        view.addSubview(redBox)
        view.addSubview(blueBox)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        let gravity = UIGravityBehavior(items: [redBox, blueBox])
        gravity.gravityDirection = CGVector(dx: 0, dy: 1)
        
        let collision = UICollisionBehavior(items: [redBox, blueBox])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        let blueBehavior = UIDynamicItemBehavior(items: [blueBox])
        blueBehavior.elasticity = 0.5
        
        let boxesAttachment = UIAttachmentBehavior(item: blueBox, attachedTo: redBox)
        boxesAttachment.damping = 0
        boxesAttachment.frequency = 4
        
        animator?.addBehavior(gravity)
        animator?.addBehavior(collision)
        animator?.addBehavior(blueBehavior)
        animator?.addBehavior(boxesAttachment)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstFinger = touches.first {
            currentLocation = firstFinger.location(in: self.view)
            
            if let attachment {
                attachment.anchorPoint = currentLocation
            } else {
                attachment = UIAttachmentBehavior(item: blueBox,
                                                  offsetFromCenter: UIOffset(horizontal: 10, vertical: 10),
                                                  attachedToAnchor: currentLocation)
                animator?.addBehavior(attachment!)
            }
            
            print("Attaching to X:\(Int(currentLocation.x)) - Y:\(Int(currentLocation.y))")
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstFinger = touches.first {
            currentLocation = firstFinger.location(in: self.view)
            
            if let attachment {
                attachment.anchorPoint = currentLocation
            } else {
                attachment = UIAttachmentBehavior(item: blueBox, attachedToAnchor: currentLocation)
                animator?.addBehavior(attachment!)
            }
            
            print("Attaching to X:\(Int(currentLocation.x)) - Y:\(Int(currentLocation.y))")
        }
    }
}

