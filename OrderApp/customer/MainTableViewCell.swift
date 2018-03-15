//
//  MainTableViewCell.swift
//  
//
//  Created by 施馨檸 on 14/03/2018.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var dishImageView: UIImageView!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var meatLabel: UILabel!
    @IBOutlet weak var dish1Label: UILabel!
    @IBOutlet weak var dish2Label: UILabel!
    @IBOutlet weak var soupLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
