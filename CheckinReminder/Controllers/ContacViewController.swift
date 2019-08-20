//
//  ContacViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/19/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit

class ContactViewController: UITableViewController {
    //MARK: - Fields
    var contacts: [Contact]?
    var dataSource: ContactsDataSource?
    
    //MARK: - Properties
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllContacts()
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

//Contact CRUD
extension ContactViewController{
    // MARK: - Data CRUD
    private func loadAllContacts(){
        contacts = [Contact]()
        let contact1 = Contact()
        contact1.firstName = "Jon"
        contact1.lastName = "Snow"
        
        let contact2 = Contact()
        contact2.firstName = "Arya"
        contact2.lastName = "Stark"
        
        let contact3 = Contact()
        contact3.firstName = "Night"
        contact3.lastName = "King"
        
        let contact4 = Contact()
        contact4.firstName = "Jamie"
        contact4.lastName = "Lannister"
        
        contacts?.append(contact1)
        contacts?.append(contact2)
        contacts?.append(contact3)
        contacts?.append(contact4)
    }
}


