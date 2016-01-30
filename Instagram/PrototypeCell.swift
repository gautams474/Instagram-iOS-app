//
//  PrototypeCell.swift
//  Instagram
//
//  Created by Gautam Sadarangani on 1/27/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit

class PrototypeCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var pictureView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
