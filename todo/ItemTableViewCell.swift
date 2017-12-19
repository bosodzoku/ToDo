//
//  ItemTableViewCell.swift
//  todo
//
//  Created by Peter on 24.05.17.
//  Copyright (c) 2017 Peter. All rights reserved.
//

import UIKit

//define a class and connect 2 labels from cell

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var nameDate: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
