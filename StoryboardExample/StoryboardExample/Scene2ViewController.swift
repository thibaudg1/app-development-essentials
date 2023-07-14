//
//  Scene2ViewController.swift
//  StoryboardExample
//
//  Created by james on 26/04/2023.
//

import UIKit

class Scene2ViewController: UIViewController {

    @IBOutlet weak var scene2Label: UILabel!
    
    var labelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        scene2Label.text = labelText
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.performSegue(withIdentifier: "SegueToScene1", sender: self)
        }
    }
}
