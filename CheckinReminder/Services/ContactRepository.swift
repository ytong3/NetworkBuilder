//
//  ContactRepository.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/20/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import Foundation

let sharedContactRepository = ContactRepository()

class ContactRepository {
    //MARK: - Properties
    
    func getContactsDueForCatchUp() -> [Contact] {
        var contacts = [Contact]()
        let contact1 = Contact()
        contact1.firstName = "Jon"
        contact1.lastName = "Snow"
        
        let contact2 = Contact()
        contact2.firstName = "Arya"
        contact2.lastName = "Stark"
        
        contacts.append(contact1)
        contacts.append(contact2)
        
        return contacts
    }
    
    func getAllContacts() -> [Contact] {
        var contacts = [Contact]()
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
        
        contacts.append(contact1)
        contacts.append(contact2)
        contacts.append(contact3)
        contacts.append(contact4)
        
        return contacts
    }
    
    // TODO: id for a contact?
    func updateContact(updatedContact: Contact) {
        print("contact should be saved")
    }
    
    func deleteContact(contactToDelete: Contact) {
        print("contact should be deleted")
    }
    
    func create(with contact: Contact) {
        print("contact should be created")
    }
}
