//
//  Contact.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import Foundation
import RealmSwift

class Contact: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var lastContactDate: Date = Date()
    @objc dynamic var cadence: Int = 4
    @objc dynamic var nextDueDate: Date!
    
    func updateDueDate() {
        let day : TimeInterval = 3600.0 * 24
        let week : TimeInterval = 7 * day
        let timeInterval : TimeInterval = Double(cadence) * week
        self.nextDueDate = Date(timeInterval: timeInterval, since: lastContactDate)
    }
}
