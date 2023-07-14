//
//  ViewController.swift
//  UIDocumentExample
//
//  Created by james on 03/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var document: MyDocument?
    var documentURL: URL?
    
    let fileManager = FileManager.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadFile()
    }
    
    func loadFile() {
        let documentsDir = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)[0]
        documentURL = documentsDir.appending(component: "savefile.txt",
                                             directoryHint: .notDirectory)
        
        guard let documentURL else { return }
        
        document = MyDocument(fileURL: documentURL)
        document?.userText = ""
        
        if fileManager.fileExists(atPath: documentURL.path()) {
            document?.open(completionHandler: { isSuccessful in
                if isSuccessful {
                    self.textView.text = self.document?.userText
                } else {
                    print("Failed to open file")
                }
            })
        } else {
            document?.save(to: documentURL, for: .forCreating, completionHandler: { isSuccessful in
                if isSuccessful {
                    print("File was created")
                } else {
                    print("File creation failed")
                }
            })
        }
        
    }


    @IBAction func saveText(_ sender: Any) {
        document?.userText = textView.text
        
        guard let documentURL else { return }
        
        document?.save(to: documentURL, for: .forOverwriting, completionHandler: { isSuccessful in
            if isSuccessful {
                print("Saved!")
            } else {
                print("Failed to save changes")
            }
        })
    }
}

