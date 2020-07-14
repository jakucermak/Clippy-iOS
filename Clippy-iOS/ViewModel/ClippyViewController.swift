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



class ClipBoardCell: UITableViewCell{

    @IBOutlet weak var clipboardContent: UILabel!
    @IBOutlet weak var clipboardTypeImage: UIImageView!

}



class ClippyViewController: UITableViewController {
    
    let pasteboard = UIPasteboard.general
    let realm = try! Realm()
    var pasteboardItems: Results<PasteBoardItem>?
    let realmLogic = RealmLogic()
   
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pasteboardItems?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClipBoardContent", for: indexPath) as! ClipBoardCell
        cell.clipboardContent.text = pasteboardItems?[indexPath.row].content
        
        return cell
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let item = PasteBoardItem()
        item.content = pasteboard.string
        item.dateCreated = Date()
        realmLogic.save(pasteBoardItem: item)
        tableView.rowHeight = 100
        loadItems()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        
    }
    
    func loadItems() {
        pasteboardItems = realm.objects(PasteBoardItem.self)
        tableView.reloadData()
    }
    
    

}
