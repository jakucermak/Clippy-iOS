//
//  DatabaseLogic.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 14/07/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import Foundation

import RxSwift
import RealmSwift
import RxRealmDataSources

class ClippyLogic {
    
    let disposeBag = DisposeBag()
    let realm = try! Realm()
    
    

    //MARK: - Bind items to TableView
    func inputTableView(tableView: UITableView){
       
        
        let itemsList = realm.objects(PasteBoardItem.self)
        
        
        Observable.collection(from: itemsList.sorted(byKeyPath: "dateCreated", ascending: false))
            .bind(to: tableView.rx.items){tv, ip, element in

                if element.contentImage != nil {
                    let cell = tv.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: IndexPath(index: ip)) as! ImageTableViewCell

                    cell.contentImage.image = UIImage(data: element.contentImage! as Data)
                    tv.rowHeight = 300
                    return cell
                }

                let cell = tv.dequeueReusableCell(withIdentifier: StringTableViewCell.identifier, for: IndexPath(index: ip)) as! StringTableViewCell
                if element.contentText.hasPrefix("https://") {
                    
                    self.urlString(cell: cell, element: element)
                    
                }else{
                    cell.typeImage.image = UIImage(systemName: "text.alignleft")
                    cell.contentString.text = element.contentText
                    
                }
                
                
                
                
                
                cell.creationDate.text = self.timePassed(from: element)
                tv.rowHeight = UITableView.automaticDimension

                return cell



            }.disposed(by: disposeBag)

        
    }
    //MARK: - Copy items to pasteboard
    
    func copyString(tableView: UITableView){
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                let pasteboard = UIPasteboard.general
                let cell = tableView.dequeueReusableCell(withIdentifier: StringTableViewCell.identifier, for: indexPath) as! StringTableViewCell
             
                if cell.contentString.text != nil{
                    let value = self.realm.objects(PasteBoardItem.self)
                    pasteboard.string = value[indexPath.row].contentText
                }
                
                
                
            }).disposed(by: disposeBag)
        
    }
    func copyImage(tableView: UITableView) {
        tableView.rx.itemSelected
            .subscribe(onNext:{ indexPath in
                let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as! ImageTableViewCell
                let pasteboard = UIPasteboard.general
                if cell.contentImage.image != nil{
                    let value = self.realm.objects(PasteBoardItem.self)
                    pasteboard.image = UIImage(data: (value[indexPath.row].contentImage)! as Data)
                }
            }).disposed(by: disposeBag)
    }
    //MARK: - Check methods if item is in Database
    
    /*
     check for string mehod
     */

    
    func checkForStrings(newItem: PasteBoardItem, pasteboard: UIPasteboard) -> Int{
        var filteredObjectCount: Int = 1
        
        if let pasteboardValue = pasteboard.string {
            let predicate = NSPredicate(format: "contentText = %@", pasteboardValue)
            let objects = realm.objects(PasteBoardItem.self).filter(predicate)
            filteredObjectCount = objects.count
        }
        return filteredObjectCount
    }
    
    
    /*
     check for image in database method
     */

    
    func checkForData(pasteboard: UIPasteboard)-> Bool{
        
        var result: Bool = false
        
        let imageData = self.realm.objects(PasteBoardItem.self).filter("type = %@", "image")
        let pasteboardImageData = NSData(data:pasteboard.image!.jpegData(compressionQuality: 0.9)!)
        
        for image in imageData {
            if let imageData = image.contentImage {
                if imageData == pasteboardImageData{
                    
                    result = true
                    break
                }else{
                 
                    result = false
                }
            }
            
        }
        return result
    }
    
    /*
     method to show elapsed time from creation
     */
    
    func timePassed(from: PasteBoardItem ) -> String {
       
        let start = Int(from.dateCreated.timeIntervalSinceNow)*(-1)
        if start == 0{
            return "now"
        }else if start < 60 {
            return "\(start) sec. ago"
        }else if start >= 60 && start <= 3600 {
            return "\(start / 60) min ago"
        }else if start >= 3600 && start <= 7200{
            return "an  hour ago "
        }else if start >= 7200{
            return "\(start / 3600) hrs. ago"
        }else if start == (3600 * 24) {
            return "a day ago"
        }else if start >= (3600 * 24){
            return "\(start / (3600 * 24)) days ago"
        }else{
            return "more days"
        }

      
    }
    
    func urlString(cell: StringTableViewCell, element: PasteBoardItem){
      
        let prefix = "https://"
        
        
        let urlString = element.contentText
        let url = URL(string: urlString)
        let domain = url?.host
        let path = element.contentText.replacingOccurrences(of: "\(prefix)\(domain!)", with: "")
        
        
        let attrs1 = [NSAttributedString.Key.foregroundColor : UIColor.gray]
        let attrs2 = [NSAttributedString.Key.foregroundColor: UIColor.label]
        
        let attStrPrefix = NSMutableAttributedString(string: prefix, attributes: attrs1)
        let attStrDomain = NSMutableAttributedString(string: domain!, attributes: attrs2)
        let attStrPath = NSMutableAttributedString(string: path, attributes: attrs1)
        
        attStrPrefix.append(attStrDomain)
        attStrPrefix.append(attStrPath)
        cell.contentString.attributedText = attStrPrefix
        cell.typeImage.image = UIImage(systemName: "link.circle")
    }
    
    
    
}

