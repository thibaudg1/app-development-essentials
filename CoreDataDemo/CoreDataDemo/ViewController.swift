//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by james on 11/05/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var address: UITextField!
    
    var context: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initCoreDataStack()
    }

    @IBAction func saveContact(_ sender: Any) {
        if let context,
           let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts",
                                                              in: context) {
            let contact = Contacts(entity: entityDescription,
                                   insertInto: context)
            
            contact.name = name.text
            contact.address = address.text
            contact.phone = phone.text
            
            do {
                try context.save()
                status.text = "Contact saved"
                name.text = ""
                address.text = ""
                phone.text = ""
            } catch {
                status.text = "Contact failed to save"
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func findContact(_ sender: Any) {
        if let context,
           let name = name.text,
           let entityDescription = NSEntityDescription.entity(forEntityName: "Contacts",
                                                              in: context) {
            let request = Contacts.fetchRequest()
            request.entity = entityDescription
            
            let predicate = NSPredicate(format: "(name = %@)", name)
            request.predicate = predicate
            
            do {
                let results = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>)
                if results.isEmpty {
                    status.text = "No records for this name"
                } else {
                    let firstMatch = results[0] as! NSManagedObject
                    
                    status.text = "\(results.count) records for this name"
                    self.name.text = firstMatch.value(forKey: "name") as? String
                    address.text = firstMatch.value(forKey: "address") as? String
                    phone.text = firstMatch.value(forKey: "phone") as? String
                }
            } catch {
                status.text = "Failed to search for contacts"
                print(error.localizedDescription)
            }
        }
    }
    
    func initCoreDataStack() {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        
        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Unable to load persistent stores: \(error)")
            } else {
                self.context = container.viewContext
            }
        }
    }
}

