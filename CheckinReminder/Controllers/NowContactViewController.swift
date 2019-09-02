//
//  NowContactViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import RealmSwift

class NowContactViewController: UITableViewController{
    //MARK: - Dependency
    let realm = try! Realm()
    //MARK: - Properties
    var contacts: Results<Contact>?
    var dataSource: ContactsDataSource?
    let todayDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Contact Today"
        
        loadDueContact()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        loadDueContact()
    }
    
    private func loadDueContact(){
        contacts = realm.objects(Contact.self).filter("nextDueDate <= %@", todayDate).sorted(byKeyPath: "lastName")
        dataSource = ContactsDataSource(with: Array(contacts!), for: "nowContactCell")
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

