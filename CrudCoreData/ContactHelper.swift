//
//  CoreDataHelper.swift
//  CrudCoreData
//
//  Created by Francisco José A. C. Souza on 24/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import CoreData

class ContactHelper: NSObject {
    static let sharedInstance = ContactHelper()
    
    var context:NSManagedObjectContext?
    
    func createContactWith(name name: String, andPhone phone: String) throws -> Contact? {
        var contact:Contact?
        
        if let context = self.context {
            contact = NSEntityDescription.insertNewObjectForEntityForName("Contact", inManagedObjectContext: context) as? Contact
            contact?.name  = name
            contact?.phone = phone
            
            try context.save()
        }
        else {
            print("You need to initialize a context value...")
        }
        
        return contact
    }
    
    func updateContact(contact: Contact, newName: String, newPhone: String) throws -> Contact? {
        if let context = self.context {
            
            contact.name  = newName
            contact.phone = newPhone
            try context.save()
        }
        else {
            print("You need to initialize a context value...")
        }
        
        return contact
    }
    
    func deleteContact(contact: Contact) throws -> Bool {
        if let context = self.context {
            context.deleteObject(contact)
            try context.save()
            
            return true
        }
        else {
            print("You need to initialize a context value...")
        }
        
        return false
    }

    func listAllContacts() throws -> [Contact]? {
        var contacts: [Contact]?
        
        if let context = self.context {
            let request = NSFetchRequest(entityName: "Contact")
            request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
            
            contacts = try context.executeFetchRequest(request) as? [Contact]
        }
        else {
            print("You need to initialize a context value...")
        }
        
        return contacts
    }
}
