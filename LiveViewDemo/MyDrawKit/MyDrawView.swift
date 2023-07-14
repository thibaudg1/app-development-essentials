//
//  MyDrawView.swift
//  MyDrawKit
//
//  Created by james on 24/05/2023.
//

import UIKit
import QuartzCore

@IBDesignable
class MyDrawView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.gray
    @IBInspectable var endRadius: CGFloat = 100
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0.0, 1.0]
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        
        if let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: locations) {
            
            let startPoint = CGPoint(x: 130, y: 100)
            let endPoint = CGPoint(x: 130, y: 120)
            let startRadius = CGFloat()
            
            context?.drawRadialGradient(gradient,
                                        startCenter: startPoint,
                                        startRadius: startRadius,
                                        endCenter: endPoint,
                                        endRadius: endRadius,
                                        options: .drawsBeforeStartLocation)
        }
    }
    

}
