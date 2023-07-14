//
//  ViewController.swift
//  AutoLayoutCode
//
//  Created by james on 26/04/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //createLayoutWithLayoutConstraints()
        createLayoutWithAnchors()
    }

    func createLayoutWithLayoutConstraints() {
        let superview = self.view
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "My Label"
        
        let myButton = UIButton()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.setTitle("My button", for: .normal)
        myButton.backgroundColor = .blue
        
        superview?.addSubview(myLabel)
        superview?.addSubview(myButton)
        
        var myConstraint = NSLayoutConstraint(item: myLabel,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: superview,
                                              attribute: .centerX,
                                              multiplier: 1,
                                              constant: 0)
        superview?.addConstraint(myConstraint)
        
        myConstraint = NSLayoutConstraint(item: myLabel,
                                          attribute: .centerY,
                                          relatedBy: .equal,
                                          toItem: superview,
                                          attribute: .centerY,
                                          multiplier: 1,
                                          constant: 0)
        superview?.addConstraint(myConstraint)
        
        myConstraint = NSLayoutConstraint(item: myButton,
                                          attribute: .trailing,
                                          relatedBy: .equal,
                                          toItem: myLabel,
                                          attribute: .leading,
                                          multiplier: 1,
                                          constant: -10)
        superview?.addConstraint(myConstraint)
        
        myConstraint = NSLayoutConstraint(item: myButton,
                                          attribute: .firstBaseline,
                                          relatedBy: .equal,
                                          toItem: myLabel,
                                          attribute: .firstBaseline,
                                          multiplier: 1,
                                          constant: 0)
        superview?.addConstraint(myConstraint)
    }
    
    func createLayoutWithAnchors() {
        let superview = self.view
        
        let myLabel = UILabel()
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.text = "My Label"
        
        let myButton = UIButton()
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.setTitle("My button", for: .normal)
        myButton.backgroundColor = .blue
        
        superview?.addSubview(myLabel)
        superview?.addSubview(myButton)
        
        myLabel.centerXAnchor.constraint(equalTo: superview!.centerXAnchor).isActive = true
        myLabel.centerYAnchor.constraint(equalTo: superview!.centerYAnchor).isActive = true
        myButton.trailingAnchor.constraint(equalTo: myLabel.leadingAnchor, constant: -10).isActive = true
        //cannot deactivate above constraints because they are not saved in a variable
        
        let myConstraint = myButton.firstBaselineAnchor.constraint(equalTo: myLabel.firstBaselineAnchor)
        myConstraint.isActive = true
        //myConstraint.isActive = false //deactivate constraint
    }
}

