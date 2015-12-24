//
//  ViewController.swift
//  CrudCoreData
//
//  Created by Francisco José A. C. Souza on 24/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    var contact: Contact?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.text  = self.contact?.name
        self.phoneTextField.text = self.contact?.phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditTap(sender: UIBarButtonItem) {
        self.phoneTextField.enabled = true
        self.nameTextField.enabled  = true
        self.saveBarButton.enabled  = true
        self.editBarButton.enabled  = false
    }
    
    @IBAction func onSaveTap(sender: UIBarButtonItem) {
        let nameText  = self.nameTextField.text!
        let phoneText = self.phoneTextField.text!
        
        if nameText.isEmpty && phoneText.isEmpty{
            self.presentAlertViewController(title: "Alert", message: "Blank fields not allowed", completion: nil)
        }
        else{
            do {
                try ContactHelper.sharedInstance.updateContact(self.contact!, newName: nameText, newPhone: phoneText)
                self.presentAlertViewController(title: "Success", message: "Contact saved successfully!", completion: {
                    (action) -> Void in
                    
                    self.phoneTextField.enabled = false
                    self.nameTextField.enabled  = false
                    self.saveBarButton.enabled  = false
                    self.editBarButton.enabled  = true
                })
            }
            catch {
                self.presentAlertViewController(title: "Error", message: "An error happen D:", completion: nil)
            }
        }
    }
    
    func presentAlertViewController(title title: String, message: String, completion: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: completion))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

