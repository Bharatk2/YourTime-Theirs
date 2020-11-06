//
//  Timer.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import Foundation

enum TimerType: Int, Codable {
  
    case date = 0
    case time
    case both
}


struct TimerEvent: Codable, Equatable {
    var name = ""
    var currentTime: String?
    var timeZone: String?
    var locationTime: String?
    var timeLeft: Date?
    var timerType = TimerType.time
    var active = false
    var timerUuid: String?
}
