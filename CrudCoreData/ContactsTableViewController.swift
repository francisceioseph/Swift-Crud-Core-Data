//
//  ContactsTableViewController.swift
//  CrudCoreData
//
//  Created by Francisco José A. C. Souza on 24/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit
import CoreData

class ContactsTableViewController: UITableViewController {
    var contacts: [Contact]?
    
    @IBOutlet var contactsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        loadContacts()
        contactsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numberOfRows = 0
        
        if let contacts = self.contacts {
            numberOfRows = contacts.count
        }
        
        return numberOfRows
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("contactCell", forIndexPath: indexPath)
        
        if let contacts = self.contacts {
            let contact = contacts[indexPath.row]
            
            cell.textLabel?.text = contact.name
            cell.detailTextLabel?.text = contact.phone
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let contact = contacts?[indexPath.row]
        performSegueWithIdentifier("toCellDetails", sender: contact)
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == .Delete) {
            let contact = contacts?[indexPath.row]
            do {
                try ContactHelper.sharedInstance.deleteContact(contact!)
                
                contacts?.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            }
            catch {
                print(error)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationViewController = segue.destinationViewController as? ContactDetailViewController{
            destinationViewController.contact = sender as? Contact
        }
    }
    
    func loadContacts() {
        do {
            self.contacts = try ContactHelper.sharedInstance.listAllContacts()
        }
        catch {
            self.contacts = []
        }
    }
}
