//
//  ImageTableViewCell.swift
//  Clippy-iOS
//
//  Created by Jakub Čermák on 04.08.2020.
//  Copyright © 2020 Jakub Čermák. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

 
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var typeImage: UIImageView!
    
 
    @IBOutlet weak var creationDate: UILabel!
    
   
    @IBOutlet weak var containerView: UIView!
    
    let cornerRadius: CGFloat = 25
    
    static let identifier = "ImageTableViewCell"
    
    static func nib() -> UINib{
        
        return UINib(nibName: "ImageTableViewCell", bundle: nil)
       
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        typeImage.image = UIImage(systemName: "photo")
        
        containerView.layer.cornerRadius = cornerRadius
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        containerView.layer.shadowRadius = 25.0
        containerView.layer.shadowOpacity = 0.9
       
        contentImage.layer.cornerRadius = cornerRadius
        contentImage.clipsToBounds = true
        contentImage.layer.borderWidth = 2.5
        contentImage.layer.borderColor = UIColor.systemBlue.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
