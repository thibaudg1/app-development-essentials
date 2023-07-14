//
//  ViewController.swift
//  DatabaseExample
//
//  Created by james on 08/05/2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var status: UILabel!
    
    var databasePath = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initDB()
    }


    @IBAction func saveContact(_ sender: Any) {
        let contactsDB = FMDatabase(path: databasePath)
        
        if contactsDB.open() {
            defer { contactsDB.close() }
            
            let insertStatement = "INSERT INTO CONTACTS (NAME, ADDRESS, PHONE) VALUES ('\(nameField.text ?? "")', '\(addressField.text ?? "")', '\(phoneField.text ?? "")')"
            
            do {
                try contactsDB.executeUpdate(insertStatement, values: nil)
            } catch {
                status.text = "Failed to add contact"
                print(error.localizedDescription)
                return
            }
            
            status.text = "Contact added!"
            nameField.text = ""
            addressField.text = ""
            phoneField.text = ""
            
        } else {
            print(contactsDB.lastErrorMessage())
        }
    }
    
    
    @IBAction func findContact(_ sender: Any) {
        guard let name = nameField.text else { return }
        
        let contactsDB = FMDatabase(path: databasePath)
        
        if contactsDB.open() {
            defer { contactsDB.close() }
            
            let queryStatement = "SELECT address, phone FROM CONTACTS WHERE name = '\(name)'"
            
            do {
                let results = try contactsDB.executeQuery(queryStatement, values: nil)
                
                if results.next() {
                    status.text = "Record found"
                    addressField.text = results.string(forColumn: "ADDRESS")
                    phoneField.text = results.string(forColumn: "PHONE")
                    
                } else {
                    status.text = "No record found"
                }
                
            } catch {
                status.text = "Failed to search for contacts"
                print(error.localizedDescription)
                return
            }
            
        } else {
            print(contactsDB.lastErrorMessage())
        }
    }
    
    func initDB() {
        let documentsDir = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask)
        
        databasePath = documentsDir[0].appending(component: "contacts.db",
                                                 directoryHint: .notDirectory).path()
        
        if !FileManager.default.fileExists(atPath: databasePath) {
            let dbHandle = FMDatabase(path: databasePath)
            
            if dbHandle.open() {
                defer { dbHandle.close() }
                
                let sql_statement = "CREATE TABLE IF NOT EXISTS CONTACTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, ADDRESS TEXT, PHONE TEXT)"
                
                guard dbHandle.executeStatements(sql_statement) else {
                    print(dbHandle.lastErrorMessage())
                    return
                }
                
            } else {
                print(dbHandle.lastErrorMessage())
            }
        }
    }
    
}

