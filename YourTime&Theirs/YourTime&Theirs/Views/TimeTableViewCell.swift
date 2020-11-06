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
    
    var timer = Timer()
    var timeZoneString: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(tick),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    

   
    var dateFormatting: DateFormatter = {
       
        let formatter = DateFormatter()
        formatter.timeStyle = .full
        return formatter
    }()
    var dateFormatting2: DateFormatter = {
          
           let formatter = DateFormatter()
        formatter.timeZone = .current
           formatter.timeStyle = .full
           return formatter
       }()
    
    
    @objc func tick() {
       dateFormatting.timeZone = TimeZone(abbreviation: timeZoneString ?? "" )
        locationTimeLabel.text = dateFormatting.string(from: Date())
        currentTimeLabel.text = dateFormatting2.string(from: Date())
      
    }
}
