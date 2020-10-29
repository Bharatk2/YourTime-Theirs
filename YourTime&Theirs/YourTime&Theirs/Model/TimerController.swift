//
//  TimerController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import Foundation

class TimeController {
    var timers = [Timer(country: "USA", timeZone: "PST", currentTime: nil, locationTime: nil, timeLeft: nil)]
    
    
    var activeTimers: [Timer] {
        return timers.filter { $0.active == true }
    }
    
    var completedTimers: [Timer] {
        return timers.filter { $0.active == false }
    }
    
    func findTimer (_ timer: Timer) -> Timer? {
        let matches = timers.filter { $0 == timer }
        assert(matches.count == 1)
        return matches[0]
    }
    
    func create(country: String, timeZone: String, currentTime: Date, locationTime: Date, timeLeft: Date, active: Bool) {
        let timer = Timer(country: country, timeZone: timeZone, currentTime: currentTime, locationTime: locationTime, timeLeft: timeLeft, active: active)
        timers.append(timer)
        saveToPersistentStore()
        
    }
    
    func toogleActive(timer t: Timer) {
           if let index = timers.firstIndex(where: { $0 == t }) {
              timers[index].active.toggle()
           }
           
           saveToPersistentStore()
       }
    
    func delete(timer timerToDelete: Timer) {
        let timerMinusTimersToDelete = timers.filter { $0 != timerToDelete }
        timers = timerMinusTimersToDelete
        
        saveToPersistentStore()
    }
    
    var timerURL: URL? {
        let fileManager = FileManager.default
        let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let timerURL = documentsDir?.appendingPathComponent("timer.plist")
        return timerURL
    }
    
    func saveToPersistentStore() {
        let encoder = PropertyListEncoder()
        do {
            let timerData = try encoder.encode(timers)
            guard let timerURL = timerURL else { return }
            try timerData.write(to: timerURL)
        } catch {
            print("Unable to save timer to plist: \(error)")
            
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let timerURL = timerURL else { return }
            let timerData = try Data(contentsOf: timerURL)
            let decoder = PropertyListDecoder()
            let decodedChart = try decoder.decode([Timer].self, from: timerData)
            self.timers = decodedChart
        } catch {
            print("Unable to decode the timer cart: \(error)")
        }
    }
}
