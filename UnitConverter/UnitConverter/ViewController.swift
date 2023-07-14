//
//  ViewController.swift
//  UnitConverter
//
//  Created by james on 25/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tempText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func convertTemp(_ sender: Any) {
        guard let temp = tempText.text,
              let fahrenheit = Double(temp) else {
            return
        }
        
        let celsius = (fahrenheit - 32) * 5 / 9
        
        let resultText = "Celsius \(celsius)"
        
        self.resultLabel.text = resultText
    }
    
    @IBAction func textFieldReturn(_ sender: UITextField) {
        _ = sender.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        tempText.endEditing(true)
    }
}

