//
//  Payment.swift
//  Trial
//
//  Created by Roshan Thapaliya on 3/26/16.
//  Copyright © 2016 Roshan Thapaliya. All rights reserved.
//

import UIKit


class PayViewController: UIViewController {

    var detailItem : Cloths!
    
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mPrice: UILabel!
    
    @IBOutlet weak var mCategory: UILabel!
    
    @IBOutlet weak var mSize: UILabel!
    
    @IBOutlet weak var mSellerName: UILabel!
    
    
    
    
    override func viewDidLoad() {
        
        mPrice.text = String(detailItem.mPrice!);
        mCategory.text = detailItem.mCategory;
        mSize.text = detailItem.mSize;
        mSellerName.text = detailItem.mName;
        mImageView.image = detailItem.mImage;
        
        
        print(detailItem.mName);
    }
    
    
    
    
    

}