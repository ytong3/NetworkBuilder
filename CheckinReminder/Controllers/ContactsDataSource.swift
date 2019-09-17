//
//  NowContactsDataSource.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/19/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import Foundation

class ContactsDataSource: NSObject, UITableViewDataSource {
    var contacts: [Contact]?
    var cellId: String = ""
    
    convenience init(with contacts: [Contact], for cellIdentifier: String) {
        self.init()
        self.contacts = contacts
        cellId = cellIdentifier
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        if let contact = contacts?[indexPath.row]{
            cell.textLabel?.text = "\(contact.firstName) \(contact.lastName)"
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts?.count ?? 1
    }
}
