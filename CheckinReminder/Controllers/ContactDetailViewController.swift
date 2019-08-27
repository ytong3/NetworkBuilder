//
//  ContactDetailViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/14/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    // MARK: - Properties
    var contact: Contact?
    
    //TODOL - make contact detal view progmatically
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastContactDateLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBAction func editButtonPressed(_ sender: Any) {
        print("edit button pressed. sugue to be performed")
        performSegue(withIdentifier: "gotoEditContact", sender: self)
    }
    
    override func viewDidLoad() {
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
    
    func setupView() {
        guard let firstName = contact?.firstName,
            let lastName = contact?.lastName,
            let lastContactDate = contact?.lastContactDate else {
                fatalError("Contact not loaded correctly")
        }
        
        nameLabel.text = "\(firstName) \(lastName)"
        
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM-dd-yyyy"
        lastContactDateLabel.text = dateFormatter.string(from: lastContactDate)
    }
}

//MARK: - Navigation
extension ContactDetailViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoEditContact"{
            let destVC = segue.destination as! EditContactViewController
            
            destVC.formToEditAContact = true
            destVC.contactVM = contact
        }
    }
}
