//
//  EditContactViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/21/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

class EditContactViewController: FormViewController {
    // dependency
    let realm = try! Realm()
    
    //view model
    var formToEditAContact: Bool = true
    var contactVM: Contact!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        //add save button
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: .saveButtonPressed)
        navigationItem.rightBarButtonItem = saveButton
        setupForm()
    }
    
    private func setupForm(){
        if formToEditAContact {
            if contactVM == nil{
                fatalError("contactToEdit not set")
            }
        }else{
            contactVM = Contact()
        }
        
        form
            +++ Section()
            <<< TextRow("fName") { row in
                row.title = "First Name"
                row.placeholder = "First Name"
                row.add(rule: RuleRequired())
                if self.formToEditAContact {
                    row.value = contactVM?.firstName
                }
                }.cellUpdate{cell, row in
                    if !row.isValid{
                        cell.textLabel?.textColor = .red
                }
            }
            
            <<< TextRow("lName") {
                $0.title = "Last Name"
                if self.formToEditAContact {
                    $0.value = self.contactVM.lastName
                }
                $0.add(rule: RuleRequired())
                }.cellUpdate{cell, row in
                    if !row.isValid{
                        cell.textLabel?.textColor = .red
                }}
            
            <<< DateRow("lastCheckinDate") {
                $0.title = "Last check-in date"
                if self.formToEditAContact {
                    $0.value = self.contactVM.lastContactDate
                }else{
                    $0.value = Date()
                }
                //TODO: last check-in date cannot be future
            }
            
            <<< StepperRow("cadence"){
                $0.title = "Cadence (weeks)"
                $0.tag = "cadence"
                $0.value = Double(self.contactVM.cadence)
                $0.cell.stepper.stepValue = 1
                $0.displayValueFor = { value in
                    guard let value = value else { return nil }
                    return "\(Int(value))"
                }
            }
            
        if self.formToEditAContact {
            form
            +++ Section()
            <<< ButtonRow("actions"){
                    $0.title = "Delete"
                    $0.onCellSelection(self.deleteButtonPressed)
            }

        }
    }
    
    //MARK: - Actions
    @objc fileprivate func saveButtonPressed(_ sender: UIBarButtonItem){
        print("contact (new or updated) should be saved in here")
        
        let formData = form.values()
        
        if self.formToEditAContact {
            print("changes to the contact should be persisted in here")
            do{
                try realm.write {
                    contactVM.firstName = formData["fName"] as! String
                    contactVM.lastName = formData["lName"] as! String
                    contactVM.lastContactDate = formData["lastCheckinDate"] as! Date
                    contactVM.cadence = Int(formData["cadence"] as! Double)
                    contactVM.calculateNextDueDate()
                }
            }catch{
                fatalError("error saving contact update")
            }
        }
        else{
            do{
                try realm.write{
                    contactVM.firstName = formData["fName"] as! String
                    contactVM.lastName = formData["lName"] as! String
                    contactVM.lastContactDate = formData["lastCheckinDate"] as! Date
                    contactVM.cadence = Int(formData["cadence"] as! Double)
                    contactVM.calculateNextDueDate()
                    realm.add(self.contactVM)
                }
                print("new contact saved")
            }catch{
                fatalError("error saving contact")
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }

    private func deleteButtonPressed(cell: ButtonCellOf<String>, row: ButtonRow){
        print("should delete the contact now")
        // should pop up a alert
        let alert = UIAlertController(title: "Confirm", message: "Confirm to delete", preferredStyle: .actionSheet)
        
        let ok = UIAlertAction(title: "OK", style: .destructive, handler: {action in
            print("OK button presses")
            do{
                try self.realm.write {
                    self.realm.delete(self.contactVM)
                }
            }catch{
                fatalError("error deleting a contact")
            }
            
            //go back to two screen back
            //self.navigationController!.popToRootViewController(animated: true)
            self.popBack(3)
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

extension Selector{
    fileprivate static let saveButtonPressed = #selector(EditContactViewController.saveButtonPressed(_:))
}
