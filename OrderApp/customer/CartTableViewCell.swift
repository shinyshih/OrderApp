//
//  CartTableViewCell.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var meatLabel: UILabel!
    @IBOutlet weak var riceLabel: UILabel!
    @IBOutlet weak var weekDayLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 3
        cellView.layer.shadowColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0).cgColor
        cellView.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.2
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

