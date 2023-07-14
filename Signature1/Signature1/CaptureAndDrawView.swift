//
//  CaptureAndDrawView.swift
//  Signature1
//
//  Created by james on 28/05/2023.
//

import UIKit

class CaptureAndDrawView: UIView {
    
    var currentPath = [CGPoint]()
    var signature = [[CGPoint]]()
    
    let useCoalescedTouches = true
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        if signature.isEmpty {
            return
        }
        
        let context = UIGraphicsGetCurrentContext()!
        context.setAllowsAntialiasing(true)
        context.setShouldAntialias(true)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(1)
        context.setLineCap(.round) // useful for drawing points (zero-length lines)
        
        signature.forEach { part in
            context.addLines(between: part)
            context.strokePath()
        }
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesBegan(touches, with: event) }
        
        handleTouches(touches)
        
        if signature.isEmpty {
            signature.insert(currentPath, at: 0)
        } else {
            signature[signature.endIndex - 1] = currentPath
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesMoved(touches, with: event) }
        
        useCoalescedTouches ? handleCoalescedTouches(with: event) : handleTouches(touches)
        
        if signature.isEmpty {
            signature.insert(currentPath, at: 0)
        } else {
            signature[signature.endIndex - 1] = currentPath
        }

        drawSignature()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        defer { super.touchesEnded(touches, with: event) }
        
        if signature.isEmpty { return }
        
        useCoalescedTouches ? handleCoalescedTouches(with: event) : handleTouches(touches)
        
        signature[signature.endIndex - 1] = currentPath
        print("Signature contains \(signature.count) parts")
        
        signature.insert([], at: signature.endIndex)
        currentPath = []
        
        drawSignature()
        
        
    }
    
    func handleTouches(_ touches: Set<UITouch>) {
        let fingers = touches.count
        if fingers > 1 {
            print("\(fingers) fingers!")
        }
        
        if let firstFinger = touches.first {
            let location = firstFinger.preciseLocation(in: self)
            
            print("New red input at X:\(Int(location.x)) - Y:\(Int(location.y))")
            
            currentPath.append(location)
        }
    }
    
    func handleCoalescedTouches(with event: UIEvent?) {
        if let event,
           let firstFinger = event.allTouches?.first,
           let coalescedTouches = event.coalescedTouches(for: firstFinger) {
            
            print("\(coalescedTouches.count) coalesced touches")
            
            coalescedTouches.forEach { touch in
                let location = touch.preciseLocation(in: self)
                currentPath.append(location)
            }
        } else {
            print("Not able to use coalesced touches")
        }
    }
    
    func drawSignature() {
        setNeedsDisplay()
    }
    
    func eraseCanva() {
        currentPath.removeAll()
        signature.removeAll()
        
        self.setNeedsDisplay()
    }

}
