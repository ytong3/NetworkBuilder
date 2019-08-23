//
//  ContactRepository.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/20/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import Foundation
import RealmSwift

let sharedContactRepository = ContactRepository()

class ContactRepository {
    //MARK: - Properties
    var realm = try! Realm()
    
    //MARK: - Methods
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
    func updateContact(updateScript:()->Void) {
        print("contact should be saved")
        do {
            try realm.write {
                updateScript()
            }
        }catch{
            print("error saving contact updates")
        }
    }
    
    func deleteContact(contactToDelete: Contact) {
        print("contact should be deleted")
        do {
            try realm.write{
                realm.delete(contactToDelete)
            }
        }catch{
            print("error deleting a contact")
        }
    }
    
    func create(with contact: Contact) {
        print("contact should be created")
        do {
            try realm.write{
                realm.add(contact)
            }
        }catch{
                print("error adding a new contact")
        }
    }
}
