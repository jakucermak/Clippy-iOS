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


class ClippyViewController:UIViewController{
    
    @IBOutlet var tableView: UITableView!
  
   
    fileprivate var pasteboardItems: Results<PasteBoardItem>?
    var clippyLogic = ClippyLogic()
    let disposeBag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
            
        clippyLogic.inputTableView(tableView: tableView)
        clippyLogic.copyToClip(tableView: tableView)

    }
    
    
    
    
    }
    
    
    







