//: [Previous](@previous)

import UIKit
import PlaygroundSupport

let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
container.backgroundColor = .blue

PlaygroundPage.current.liveView = container

let square = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
square.backgroundColor = .red

container.addSubview(square)

UIView.animate(withDuration: 5.0, animations: {
    square.backgroundColor = UIColor.white
    let rotation = CGAffineTransform(rotationAngle: 3.14)
    square.transform = rotation
})

var myChar4 = "\u{0058}"

//: [Next](@next)
