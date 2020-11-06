//
//  EventTableViewController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/30/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit
extension Date {

    func offsetFrom(date: Date, type: TimerType) -> String {

        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)

        var seconds = ""
        var minutes = ""
        var hours = ""
        var days = ""
        var typeStr = ""

        switch type {
        case .both:
            typeStr = " 📆⏰"
            seconds = "\(difference.second ?? 0)s"
            minutes = "\(difference.minute ?? 0)m" + " " + seconds
            hours = "\(difference.hour ?? 0)h" + " " + minutes
            days = "\(difference.day ?? 0)d" + " " + hours
        case .date:
            typeStr = " 📆"
            days = "\(difference.day ?? 0) Days"
        case .time:
            typeStr = " ⏰"
            seconds = "\(difference.second ?? 0)s"
            minutes = "\(difference.minute ?? 0)m" + " " + seconds
            hours = "\(difference.hour ?? 0)h" + " " + minutes
            days = "\(difference.day ?? 0)d" + " " + hours
        }

        if let day = difference.day, day          > 0 { return days + typeStr }
        if let hour = difference.hour, hour       > 0 { return hours + typeStr }
        if let minute = difference.minute, minute > 0 { return minutes + typeStr }
        if let second = difference.second, second > 0 { return seconds + typeStr }
        return .finishedMsg
    }

}

extension String {
    static var finishedMsg = "Done"
    static var appTitle = "Count🔻"
    static var noTag = "no tag"
}

var timerController = TimerController()
var notificationController = NotificationController()
protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: AnyObject)
}
class EventTableViewController: UITableViewController {
    
    var timeZoneString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }

    
    // MARK: - Table view data source

   
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath) as? TimeTableViewCell else { return UITableViewCell() }
       
        cell.timeZoneString = self.timeZoneString

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension EventTableViewController: MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: AnyObject) {
        self.performSegue(withIdentifier: "TimeCell", sender:dataobject )
    }
    
    
}
