//
//  DatabaseLogic.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 14/07/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import Foundation
import RxRealm
import RxSwift
import RealmSwift

class ClippyLogic: UIViewController {
    
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    
    //MARK: - Bind items to TableView
    func inputTableView(tableView: UITableView){
       let items = realm.objects(PasteBoardItem.self)
      
        Observable.collection(from: items)
            .bind(to: tableView.rx.items(cellIdentifier: "ClipBoardContent", cellType: ClipBoardCell.self)){ index, element, cell in
                cell.clipboardContent.text = element["content"] as? String
 
            }.disposed(by: disposeBag)
    
       }
    //MARK: - Copy items from paste board
    
    func copyToClip(tableView: UITableView){
        tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                let pasteboard = UIPasteboard.general
                let cell = tableView.cellForRow(at: indexPath) as! ClipBoardCell
                pasteboard.string = cell.clipboardContent.text
            }).disposed(by: disposeBag)
    }
    
    
    
    
}
