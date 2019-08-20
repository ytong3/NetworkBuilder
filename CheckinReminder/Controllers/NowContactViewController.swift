//
//  NowContactViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit

class NowContactViewController: UITableViewController{
    //MARK: - Fields
    var contacts: [Contact]?
    var dataSource: ContactsDataSource?
    
    //MARK: - Properties    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAvailableContacts()
        dataSource = ContactsDataSource(with: self.contacts!, for: "nowContactCell")
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
}

// MARK: - Table view delegate
extension NowContactViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContact", sender: self)
    }
}

// MARK: - Segues
extension NowContactViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToContact"{
            let destVC = segue.destination as! ContactDetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destVC.contact = contacts?[indexPath.row]
            }
        }
    }
}

extension NowContactViewController{
    // MARK: - Data CRUD
    private func loadAvailableContacts(){
        contacts = [Contact]()
        let contact1 = Contact()
        contact1.firstName = "Jon"
        contact1.lastName = "Snow"
        
        let contact2 = Contact()
        contact2.firstName = "Arya"
        contact2.lastName = "Stark"
        
        contacts?.append(contact1)
        contacts?.append(contact2)
    }
}

