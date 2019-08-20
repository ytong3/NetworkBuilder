//
//  Contact.swift
//  CheckinReminder
//
//  Created by Yue Tong on 8/13/19.
//  Copyright © 2019 Biang Studio. All rights reserved.
//

import Foundation
import RealmSwift

class Contact {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var lastContactDate: Date = Date(timeIntervalSince1970: 1)
    @objc dynamic var notes: [String] = [String]()
}
