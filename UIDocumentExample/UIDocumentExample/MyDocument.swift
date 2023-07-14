//
//  MyDocument.swift
//  UIDocumentExample
//
//  Created by james on 03/05/2023.
//

import UIKit

class MyDocument: UIDocument {
    var userText: String? = "Some Sample Text"
    
    override func contents(forType typeName: String) throws -> Any {
        if let userText {
            return Data(userText.utf8)
        } else {
            return Data()
        }
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let data = contents as? Data {
            userText = String(data: data, encoding: .utf8)
        }
    }
}
