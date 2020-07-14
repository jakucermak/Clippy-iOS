//
//  DatabaseLogic.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 14/07/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import Foundation
import RealmSwift

class RealmLogic {
    let realm = try! Realm()
    
    func save(pasteBoardItem: PasteBoardItem) {
        do {
            try realm.write{
                realm.add(pasteBoardItem)
            }
        } catch {
            fatalError()
        }
    }
    
    
        }
