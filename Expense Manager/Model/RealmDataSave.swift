//
//  RealmDataSave.swift
//  Expense Manager
//
//  Created by Rukhsar on 21/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import Foundation
import RealmSwift
class RealmDataSave : Object {
    @objc dynamic var incomeStringRealm: String = ""
    @objc dynamic var expenceStringRealm: String = ""
    @objc dynamic var incomeamountRealm: Int = 0
    @objc dynamic var expenceamountRealm: Int = 0
    @objc dynamic var categoryRealm: String = ""
    @objc dynamic var dateRealm: String = ""
    @objc dynamic var timeRealm: String = ""
    @objc dynamic var dayRealm: String = ""
    @objc dynamic var paymentModeRealm: String = ""
    @objc dynamic var noteRealm: String = ""
    
}
