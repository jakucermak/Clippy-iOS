//
//  ViewController.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 21/05/2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit



class ClipBoardCell: UITableViewCell{
    
    @IBOutlet weak var clipboardContent: UILabel!
    @IBOutlet weak var clipboardTypeImage: UIImageView!
    
    
}



class ClippyViewController: UITableViewController {
   
    let pasteboard = UIPasteboard.general
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClipBoardContent", for: indexPath) as! ClipBoardCell
        
        if let paste = pasteboard.string {
            cell.clipboardContent.text = paste
            cell.clipboardTypeImage.image = UIImage(systemName: "text.quote")
        }
       
        return cell
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        tableView.rowHeight = 100
        
    }


}

