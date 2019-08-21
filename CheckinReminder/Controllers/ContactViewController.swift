//
//  ContacViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/19/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {
    //MARK: - Dependency
    let contactRepo = sharedContactRepository
    
    //MARK: - Properties
    var contacts: [Contact]?
    var dataSource: ContactsDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = sharedContactRepository.getAllContacts()
        dataSource = ContactsDataSource(with: self.contacts!, for: "contactCell")
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

extension ContactViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContact", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContact"{
            let destVC = segue.destination as! ContactDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destVC.contact = contacts?[indexPath.row]
            }
        }
    }
}


