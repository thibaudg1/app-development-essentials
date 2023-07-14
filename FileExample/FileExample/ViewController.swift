//
//  ViewController.swift
//  FileExample
//
//  Created by james on 03/05/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textBox: UITextField!
    
    var fileManager = FileManager.default
    var documentsDir: String?
    var filePath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkFile()
    }

    @IBAction func saveText(_ sender: Any) {
        if let text = textBox.text {
            let dataBuffer = text.data(using: .utf8)
            
            fileManager.createFile(atPath: filePath,
                                   contents: dataBuffer)
        }
    }
    
    func checkFile() {
        let dirPaths = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        filePath = dirPaths[0].appending(component: "datafile.dat").path()
        
        if fileManager.fileExists(atPath: filePath) {
            if let dataBuffer = fileManager.contents(atPath: filePath) {
                let dataString = NSString(data: dataBuffer,
                                          encoding: String.Encoding.utf8.rawValue)
                self.textBox.text = dataString as String?
            }
        }
    }
    
}

