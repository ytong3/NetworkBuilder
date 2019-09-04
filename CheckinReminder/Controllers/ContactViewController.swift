//
//  ContacViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/19/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import RealmSwift

class ContactViewController: UITableViewController {
    //MARK: - Dependency
    let contactRepo = sharedContactRepository
    let realm = try! Realm()
    
    //MARK: - Properties
    var contacts: Results<Contact>?
    var dataSource: ContactsDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllContacts()
        
        //title
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Contact"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllContacts()
    }
    
    private func loadAllContacts(){
        contacts = realm.objects(Contact.self).sorted(byKeyPath: "lastName", ascending: true)
        dataSource = ContactsDataSource(with: Array(contacts!), for: "contactCell")
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
        }else if segue.identifier == "gotoAddContact" {
            let destVC = segue.destination as! EditContactViewController
            
            destVC.formToEditAContact = false
        }
    }
}


