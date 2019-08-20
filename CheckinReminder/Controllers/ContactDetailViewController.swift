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
    
    override func viewDidLoad() {
        guard let firstName = contact?.firstName,
              let lastName = contact?.lastName,
              let lastContactDate = contact?.lastContactDate else {
            fatalError("Contact not loaded correctly")
        }
        
        nameLabel.text = "\(firstName) \(lastName)"
    }
}
