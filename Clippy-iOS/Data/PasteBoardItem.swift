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
    @objc dynamic var contentText: String = ""
    @objc dynamic var contentImage: NSData?
    @objc dynamic var dateCreated = NSDate()
    @objc dynamic var type: String = ""
    @objc dynamic var id: Int = 0
    var tags = List<String>()
    
    convenience init(tag:String){
        self.init()
        self.tags.append(tag)
    }
    
}


