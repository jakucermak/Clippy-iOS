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



class ClipBoardCell: UITableViewCell{
    
    @IBOutlet weak var clipboardContent: UILabel!
    @IBOutlet weak var clipboardTypeImage: UIImageView!
    
}


class ClippyViewController: ClippyLogic{
    
    @IBOutlet var tableView: UITableView!
  
   
    fileprivate var pasteboardItems: Results<PasteBoardItem>?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
            
        inputTableView(tableView: tableView)
        copyToClip(tableView: tableView)
    }
    
    
    }
    
    
    







