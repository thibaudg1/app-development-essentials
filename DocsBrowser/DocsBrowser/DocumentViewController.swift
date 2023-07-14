//
//  DocumentViewController.swift
//  DocsBrowser
//
//  Created by james on 03/05/2023.
//

import UIKit

class DocumentViewController: UIViewController {
    
    @IBOutlet weak var documentText: UITextView!
    @IBOutlet weak var documentNameLabel: UILabel!
    
    var document: Document?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Access the document
        document?.open(completionHandler: { (success) in
            if success {
                // Display the content of the document, e.g.:
                self.documentNameLabel.text = self.document?.fileURL.lastPathComponent
                self.documentText.text = self.document?.userText
            } else {
                // Make sure to handle the failed import appropriately, e.g., by presenting an error message to the user.
            }
        })
    }
    
    @IBAction func saveText(_ sender: Any) {
        document?.userText = documentText.text
        
        if let url = document?.fileURL {
            document?.save(to: url,
                           for: .forOverwriting, completionHandler: { isSuccessful in
                if isSuccessful {
                    print("File overwrite is a success")
                } else {
                    print("File overwrite is a failure")
                }
            })
        }
    }
    
    @IBAction func dismissDocumentViewController() {
        dismiss(animated: true) {
            self.document?.close(completionHandler: nil)
        }
    }
}
