//
//  TimerController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import Foundation

protocol TimerModelDelegate {
    func create(name: String, currentTime: String, timeZone: String, locationTime: String, timeLeft: Date, timerType: TimerType, active: Bool)
    func update(timer t: TimerEvent, name: String, currentTime: String, timeZone: String, locationTime: String, timeLeft: Date?, timerType: TimerType, active: Bool)
}
class TimerController {
    
    var timers: [TimerEvent] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    var filter = ""
    
  
    var activeTimers: [TimerEvent] {
        return timers.filter { $0.active == true }
    }
    
    var completedTimers: [TimerEvent] {
        return timers.filter { $0.active == false }
    }
    
    func findTimer (_ timer: TimerEvent) -> TimerEvent? {
        let matches = timers.filter { $0 == timer }
        assert(matches.count == 1)
        return matches[0]
    }
    
    func findTimerIndex(_ t: TimerEvent) -> Int? {
           if let index = timers.firstIndex(where: { $0 == t }) {
               return index
           } else {
               return nil
           }
       }
    
    func create(name: String, currentTime: String,  timeZone: String, locationTime: String, timeLeft: Date, timerType: TimerType = .time, active: Bool) {
        let timer = TimerEvent(name: name, currentTime: currentTime, timeZone: timeZone, locationTime: locationTime, timeLeft: timeLeft, timerType: timerType, active: active)
        
        timers.append(timer)
        saveToPersistentStore()
         if let uuid = notificationController.scheduleNotification(timer: timer) {
                  timerController.notificationScheduled(timer: timer, timerUuid: uuid)
              }
        
    }
    
    func notificationScheduled(timer t: TimerEvent, timerUuid: String) {
        if let index = timers.firstIndex(where: { $0 == t }) {
            timers[index].timerUuid = timerUuid
            timers[index].active = true
        }
        
        saveToPersistentStore()
    }

    func notificationCanceled(timer t: TimerEvent) {
        if let index = timers.firstIndex(where: { $0 == t }) {
            timers[index].timerUuid = nil
            timers[index].active = false
        }
        
        saveToPersistentStore()
    }
    
    func update(timer t: TimerEvent, name: String,
                currentTime: String, timeZone: String, locationTime: String, timeLeft: Date, timerType: TimerType, active: Bool) {
     
         guard let index = findTimerIndex(t) else { fatalError("Timer Object Not Found") }
        
        timers[index].name = name
        timers[index].currentTime = currentTime
        timers[index].timeZone = timeZone
        timers[index].locationTime = locationTime
        timers[index].timeLeft = timeLeft
        timers[index].timerType = timerType
        timers[index].active = active
        
        if timers[index] /* Now "updated" */ == t /* The Prior State */ {
            // This is a nop. User didn't make any changes and clicked up. Just exit.
            return
        }
        
        saveToPersistentStore()

        if let uuid = notificationController.scheduleNotification(timer: timers[index]) {
            timerController.notificationScheduled(timer: timers[index], timerUuid: uuid)
        }
    }
    
    func toogleActive(timer t: TimerEvent) {
           if let index = timers.firstIndex(where: { $0 == t }) {
              timers[index].active.toggle()
           }
           
           saveToPersistentStore()
       }
    
    func delete(timer timerToDelete: TimerEvent) {
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
            let decodedChart = try decoder.decode([TimerEvent].self, from: timerData)
            self.timers = decodedChart
        } catch {
            print("Unable to decode the timer cart: \(error)")
        }
    }
}
