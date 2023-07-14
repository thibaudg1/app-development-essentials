//
//  ViewController.swift
//  StoryboardExample
//
//  Created by james on 26/04/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destination = segue.destination as! Scene2ViewController
        
        destination.labelText = "Arrived from Scene 1"
    }
    
    @IBAction func returned(segue: UIStoryboardSegue) {
        sceneLabel.text = "Returned from Scene 2"
    }

}

