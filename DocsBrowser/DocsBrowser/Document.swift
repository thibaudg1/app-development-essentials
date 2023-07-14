//
//  Document.swift
//  DocsBrowser
//
//  Created by james on 03/05/2023.
//

import UIKit

class Document: UIDocument {
    
    var userText: String?
    
    override func contents(forType typeName: String) throws -> Any {
        // Encode your document with an instance of NSData or NSFileWrapper
        if let userText {
            let length = userText.lengthOfBytes(using: .utf8)
            return NSData(bytes: userText, length: length)
        } else {
            return Data()
        }
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        // Load your document from contents
        if let userContent = contents as? Data {
            userText = NSString(data: userContent,
                                encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
}

