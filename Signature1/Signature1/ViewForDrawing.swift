//
//  ViewForDrawing.swift
//  Signature1
//
//  Created by james on 28/05/2023.
//

import UIKit
//import QuartzCore

class ViewForDrawing: UIView {
    var signatureParts = [[CGPoint]]()
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setStrokeColor(UIColor.white.cgColor)
        
        if signatureParts.isEmpty {
            context?.setFillColor(self.backgroundColor?.cgColor ?? UIColor.black.cgColor)
            context?.fill(rect)
            
            return
        }
        
        signatureParts.forEach { part in
            guard part.count > 1 else { return }
            
            context?.move(to: part[0])
            
            for i in 1..<part.endIndex {
                context?.addLine(to: part[i])
            }
            
            context?.strokePath()
        }
    }
    
    
    func drawCoordinates(_ newPart: [CGPoint]) {
        guard newPart.count > 1 else { return }
        
        signatureParts.append(newPart)
        
        self.setNeedsDisplay()
    }
    
    func eraseCanva() {
        signatureParts.removeAll()
        
        self.setNeedsDisplay()
    }

}
