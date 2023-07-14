//
//  DrawingUIView2.swift
//  Draw2D
//
//  Created by james on 27/05/2023.
//

import UIKit
import QuartzCore

@IBDesignable
class DrawingUIView2: UIView {
    @IBInspectable var startColor: UIColor = UIColor.white
    @IBInspectable var endColor: UIColor = UIColor.gray
    @IBInspectable var endRadius: CGFloat = 100
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        //drawImage(in: rect)
        //drawFilteredImage(in: rect)
        
        drawLine()
        
        drawPoint()
        
        drawRect()
        
        drawEllipse()
        
        fillRect()
        
        drawArc()
        
        drawQuadraticBezierCurve()
        
        drawCubicBezierCurve()
        
        drawShadows()
    }
    
    func drawImage(in rect: CGRect) {
        let image = UIImage(named: "myImage")
        //let topLeftCornerOrigin = CGPoint()
        //image?.draw(at: topLeftCornerOrigin) //draw full size picture down-right from an origin point
        image?.draw(in: rect, blendMode: .normal, alpha: 0.3)
    }
    
    func drawFilteredImage(in rect: CGRect) {
        if let image = UIImage(named: "myImage"),
           let filter = CIFilter(name: "CISepiaTone") {
            let ciImage = CIImage(image: image)
            
            filter.setDefaults()
            filter.setValue(ciImage, forKey: "inputImage")
            filter.setValue(0.7, forKey: "inputIntensity")
            
            guard let outputImage = filter.outputImage else { return }
            let uiImage = UIImage(ciImage: outputImage)
            
            uiImage.draw(in: rect)
        }
    }
    
    func drawPoint() {
        let ctx = UIGraphicsGetCurrentContext()
        ctx?.setFillColor(UIColor.red.cgColor)
        ctx?.fill(CGRect(x: 300, y: 500, width: 1, height: 1))
        //hint: increase width and length to spot this tiny rect on screen
    }
    
    func drawLine() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3.0)
        context?.setStrokeColor(startColor.cgColor)
        context?.move(to: CGPoint(x: 50, y: endRadius))
        context?.addLine(to: CGPoint(x: 300, y: 400))
        context?.strokePath()
        
        context?.move(to: CGPoint(x: 300, y: 400))
        context?.setStrokeColor(endColor.cgColor)
        context?.addLine(to: CGPoint(x: 50, y: 800 - endRadius))
        context?.strokePath()
        
        context?.move(to: CGPoint(x: 50, y: 800 - endRadius))
        context?.setStrokeColor(endColor.cgColor)
        context?.addArc(center: CGPoint(x: 50, y: 400), radius: (400 - endRadius), startAngle: -1.57, endAngle: 1.57, clockwise: false)
        context?.strokePath()
    }
    
    func drawRect() {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(startColor.cgColor)
        context?.setLineWidth(3)
        let rectangle = CGRect(x: 5, y: 5, width: endRadius, height: endRadius / 2)
        context?.addRect(rectangle)
        context?.strokePath()
    }
    
    func drawEllipse() {
        let context = UIGraphicsGetCurrentContext()
        //context?.setStrokeColor(endColor.cgColor)
        context?.setLineWidth(5)
        let ellipseRect = CGRect(origin: CGPoint(x: 10, y: 50), size: CGSize(width: 80, height: 50))
        context?.addEllipse(in: ellipseRect)
        context?.setFillColor(endColor.cgColor)
        context?.fillPath()
    }
    
    func fillRect() {
        let context = UIGraphicsGetCurrentContext()
        context?.setStrokeColor(startColor.cgColor)
        context?.setFillColor(endColor.cgColor)
        context?.setLineWidth(7)
        
        let rectangle = CGRect(x: self.bounds.maxX - 100, y: 5, width: 70, height: endRadius / 2)
        context?.addRect(rectangle)
        context?.strokePath()
        context?.fill(rectangle)
    }
    
    func drawArc() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setStrokeColor(UIColor.blue.cgColor)
        context?.move(to: CGPoint(x: 100, y: 100))
        context?.addArc(tangent1End: CGPoint(x: 100, y: 200),
                 tangent2End: CGPoint(x: 300, y: 200), radius: 100)
        context?.fillPath()
    }
    
    func drawQuadraticBezierCurve() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setStrokeColor(startColor.cgColor)
        context?.move(to: CGPoint(x: 100, y: 100))
        context?.addQuadCurve(to: CGPoint(x: 200, y: 200), control: CGPoint(x: 100, y: 200))
        context?.strokePath()
    }
    
    func drawCubicBezierCurve() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(1)
        context?.setStrokeColor(UIColor.systemTeal.cgColor)
        context?.move(to: CGPoint(x: 100, y: 400))
        context?.addCurve(to: CGPoint(x: 110, y: 380), control1: CGPoint(x: 150, y: 420), control2: CGPoint(x: 150, y: 500))
        context?.strokePath()
    }
    
    func drawShadows() {
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(3)
        context?.setStrokeColor(UIColor.systemTeal.cgColor)
        
        context?.saveGState() // to avoid shadows to be drawn for every following paths
        
        context?.setShadow(offset: CGSize(width: -20, height: -20), blur: 6)
        let ellipseRect = CGRect(origin: CGPoint(x: 30, y: 620), size: CGSize(width: 180, height: 80))
        context?.addEllipse(in: ellipseRect)
        context?.strokePath()
        
        context?.restoreGState()
    }
    
    func drawRadial() {
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
