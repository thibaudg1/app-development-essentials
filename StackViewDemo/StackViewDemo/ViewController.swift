//
//  ViewController.swift
//  StackViewDemo
//
//  Created by james on 28/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cupStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func removeCup(_ sender: Any) {
        guard let lastCupView = cupStackView.arrangedSubviews.last else { return }
        
        UIView.animate(withDuration: 0.25) {
            self.cupStackView.removeArrangedSubview(lastCupView)
            lastCupView.removeFromSuperview()
            self.cupStackView.layoutIfNeeded()
        }
    }
    
    @IBAction func addCup(_ sender: Any) {
        let cupImage = UIImage(named: "RedCoffeeCup")
        let cupView = UIImageView(image: cupImage)
        cupView.contentMode = .scaleAspectFit
        
        UIView.animate(withDuration: 0.75) {
            self.cupStackView.addArrangedSubview(cupView)
            self.cupStackView.layoutIfNeeded()
        }
    }
}

