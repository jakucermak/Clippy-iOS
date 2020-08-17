//
//  ViewController.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 21/05/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import RxRealm
import SwipeCellKit


class ClippyViewController:UIViewController {
    
    
    
    @IBOutlet var tableView: UITableView!
  
   
    var clippyLogic = ClippyLogic()
    let disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        tableView.register(ImageTableViewCell.nib(), forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(StringTableViewCell.nib(), forCellReuseIdentifier: StringTableViewCell.identifier)
     
        tableView.tableFooterView = UIView()
     
            
        clippyLogic.inputTableView(tableView: tableView)
        clippyLogic.copyString(tableView: tableView)
        clippyLogic.copyImage(tableView: tableView)
        
       
    }

    
    
    
    
    }
    
    
    







