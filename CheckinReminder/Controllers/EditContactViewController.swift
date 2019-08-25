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
                row.onChange{ [unowned self ] row in
                    if let fName = row.value{
                        self.contactVM.firstName = fName
                    }
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
                $0.onChange{[unowned self] row in
                    if let lName = row.value{
                        self.contactVM.lastName = lName
                    }
                }
                }.cellUpdate{cell, row in
                    if !row.isValid{
                        cell.textLabel?.textColor = .red
                    }
            }
            
            <<< DateRow("lastCheckinDate") {
                $0.title = "Last check-in date"
                if self.formToEditAContact {
                    $0.value = self.contactVM.lastContactDate
                }else{
                    $0.value = Date()
                }
                //TODO: last check-in date cannot be future
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
    
    //MARK: - Actions
    @objc fileprivate func saveButtonPressed(_ sender: UIBarButtonItem){
        print("contact (new or updated) should be saved in here")
        if self.formToEditAContact {
            print("changes to the contact should be persisted in here")
        }
        else{
            do{
                try realm.write{
                    realm.add(self.contactVM)
                }
                print("new contact saved")
            }catch{
                fatalError("error saving contact")
            }
        }
        _ = navigationController?.popViewController(animated: true)
    }
}

extension Selector{
    fileprivate static let saveButtonPressed = #selector(EditContactViewController.saveButtonPressed(_:))
}
