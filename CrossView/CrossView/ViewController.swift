//
//  ViewController.swift
//  CrossView
//
//  Created by james on 26/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewB: UIView!
    @IBOutlet weak var myButton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewB.removeConstraint(centerConstraint)
        
        myLabel.trailingAnchor.constraint(equalTo: myButton.trailingAnchor).isActive = true
    }


}

