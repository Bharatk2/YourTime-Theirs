//
//  Timer.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import Foundation

struct Timer: Codable, Equatable {
    var country: String?
    var timeZone: String?
    var currentTime: Date?
    var locationTime: Date?
    var timeLeft: Date?
    var active = false 
}
