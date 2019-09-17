//
//  NowContactViewController.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications

class NowContactViewController: UITableViewController{
    //MARK: - Dependency
    let realm = try! Realm()
    //MARK: - Properties
    let cellId = "nowContactCell"
    var contacts: Results<Contact>?
    var dataSource: ContactsDataSource?
    let todayDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // table style
        tableView.separatorStyle = .none
        
        //title
        navigationItem.largeTitleDisplayMode = .automatic
        navigationItem.title = "Today"
        
        UNUserNotificationCenter.current().requestAuthorization(options: .badge)
        { (granted, error) in
            if error != nil {
                // success!
            }
        }
        
        tableView.register(DueContactCell.self, forCellReuseIdentifier: cellId)
        
        loadDueContact()
        UIApplication.shared.applicationIconBadgeNumber = contacts?.count ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated )
        loadDueContact()
        UIApplication.shared.applicationIconBadgeNumber = contacts?.count ?? 0
    }
    
    private func loadDueContact(){
        contacts = realm.objects(Contact.self).filter("nextDueDate <= %@", todayDate).sorted(byKeyPath: "lastName")
        tableView.reloadData()
    }
}

// MAKR: - Table view data source
extension NowContactViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! DueContactCell
        cell.contact = contacts![indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 0
    }
}

// MARK: - Table view delegate
extension NowContactViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToContact", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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

