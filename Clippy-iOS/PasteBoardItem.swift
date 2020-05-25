//
//  PasteBoardItem.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 25/05/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import Foundation
import RealmSwift


class PasteBoardItem: Object{
    @objc dynamic var content: String!
    @objc dynamic var dateCreated: NSDate!
    
    
}
