//
//  NewContactViewController.swift
//  CrudCoreData
//
//  Created by Francisco José A. C. Souza on 24/12/15.
//  Copyright © 2015 Francisco José A. C. Souza. All rights reserved.
//

import UIKit

class NewContactViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onDoneTap(sender: UIBarButtonItem) {
        let nameText = self.nameTextField.text!
        let phoneText = self.phoneTextField.text!
        
        if nameText.isEmpty && phoneText.isEmpty{
            self.presentAlertViewController(title: "Alert", message: "Blank fields not allowed", completion: nil)
        }
        else{
            do {
                try ContactHelper.sharedInstance.createContactWith(name: nameText, andPhone: phoneText)
                self.presentAlertViewController(title: "Success", message: "Contact saved successfully!", completion: {
                    (action) -> Void in
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
            catch {
                self.presentAlertViewController(title: "Error", message: "An error happen D:", completion:  {
                    (action) -> Void in

                    self.dismissViewControllerAnimated(true, completion: nil)
                })
            }
        }
    }
    
    @IBAction func onCancelTap(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func presentAlertViewController(title title: String, message: String, completion: ((UIAlertAction)->Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: completion))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
}
