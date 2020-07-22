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
    @objc dynamic var content: String = ""
    @objc dynamic var dateCreated = Date()
    @objc dynamic var type: String = ""
    @objc dynamic var typeImage: String {
        switch type {
        case "text":
            return "text.alignleft"
        case "image":
            return "photo.fill"
            
        case "link":
            return "link"
        
        default:
           return "text"
        }
    }
    
}


