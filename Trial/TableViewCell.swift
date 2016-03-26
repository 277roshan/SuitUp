//
//  TableViewCell.swift
//  Trial
//
//  Created by Preksha Koirala on 3/25/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//


import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var mImageView: UIImageView!
 
    
    @IBOutlet weak var mDressName: UILabel!
    
    @IBOutlet weak var mCategory: UILabel!
    
    @IBOutlet weak var mPrice: UILabel!
    
    @IBOutlet weak var mSize: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
