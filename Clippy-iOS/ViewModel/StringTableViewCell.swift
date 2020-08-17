//
//  StringTableViewCell.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 04.08.2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit

class StringTableViewCell: UITableViewCell {

    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var typeImage: UIImageView!
    @IBOutlet weak var contentString: UILabel!
    static let identifier = "StringTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "StringTableViewCell", bundle: nil)
    }
    
    let configuration = UIImage.SymbolConfiguration(scale: .small)
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
