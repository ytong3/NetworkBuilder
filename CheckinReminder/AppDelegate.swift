//
//  AppDelegate.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        var realm = try! Realm()
        // seed the realm
        do{
//            let contact1 = Contact()
//            contact1.firstName = "Jon"
//            contact1.lastName = "Snow"
//            contact1.calculateNextDueDate()
//
//            let contact2 = Contact()
//            contact2.firstName = "Arya"
//            contact2.lastName = "Stark"
//
//            let contact3 = Contact()
//            contact3.firstName = "Night"
//            contact3.lastName = "King"
//
//            let contact4 = Contact()
//            contact4.firstName = "Jamie"
//            contact4.lastName = "Lannister"
//
//            try realm.write {
//                realm.add(contact1)
//                realm.add(contact2)
//                realm.add(contact3)
//                realm.add(contact4)
//            }
        }catch{
            fatalError("failed to seed realm")
        }
        
        return true
    }
}

