//
//  AttractionDetailsViewController.swift
//  TableViewStory
//
//  Created by james on 27/04/2023.
//

import UIKit
import WebKit

class AttractionDetailsViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    var webSite: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let webSite,
           let url = URL(string: webSite) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
