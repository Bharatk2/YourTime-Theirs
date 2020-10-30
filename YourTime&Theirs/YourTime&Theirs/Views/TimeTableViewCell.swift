//
//  TimeTableViewCell.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/30/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit

class TimeTableViewCell: UITableViewCell {

    @IBOutlet weak var currentTimeLabel: UILabel!
    
    @IBOutlet weak var locationTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
