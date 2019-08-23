//
//  EditContactViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/21/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import Eureka

class EditContactViewController: FormViewController {
    var formToEditAContact: Bool = true
    var contactToEdit: Contact?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
    }
    
    private func setupForm(){
        
        let contact: Contact
        if formToEditAContact {
            if contactToEdit == nil{
                fatalError("contactToEdit not set")
            }else{
                contact = contactToEdit!
            }
        }else{
            contact = Contact()
        }
        
        form
            +++ Section()
            <<< TextRow("fName") { row in
                row.title = "First Name"
                row.placeholder = "First Name"
                row.add(rule: RuleRequired())
                if self.formToEditAContact {
                    row.value = contact.firstName
                }
                }.cellUpdate{cell, row in
                    if !row.isValid{
                        cell.textLabel?.textColor = .red
                    }
            }
            
            <<< TextRow("lName") {
                $0.title = "Last Name"
                if self.formToEditAContact {
                    $0.value = contact.lastName
                }
                $0.add(rule: RuleRequired())
                }.cellUpdate{cell, row in
                    if !row.isValid{
                        cell.textLabel?.textColor = .red
                    }
            }
            
            <<< DateRow("lastCheckinDate") {
                $0.title = "Last check-in date"
                if self.formToEditAContact {
                    $0.value = contact.lastContactDate
                }else{
                    $0.value = Date()
                }
            }
            
            <<< StepperRow(){
                $0.title = "Cadence"
                $0.tag = "integer"
                $0.value = 0
                
                $0.cell.stepper.stepValue = 1
                $0.displayValueFor = { value in
                    guard let value = value else { return nil }
                    return "\(Int(value))"
                }
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        //save the form data
        
        //dismiss current view controller
    }
}
