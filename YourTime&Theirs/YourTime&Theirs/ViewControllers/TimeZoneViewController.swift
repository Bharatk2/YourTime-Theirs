//
//  TimeZoneViewController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit
import TimeZonePicker
class TimeZoneViewController: UIViewController {

    @IBOutlet weak var timeZoneName: UILabel!
    @IBOutlet weak var timeZoneOffset: UILabel!
    var detailVC: CountryViewController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePickerTapped(_ sender: Any) {
        
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
               present(timeZonePicker, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TimeZoneViewController: TimeZonePickerDelegate {
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
        if timeZoneName.text == detailVC?.chooseCountryLabel.text {
            timeZoneName.text = timeZone.identifier
        } else {
                 timeZoneName.text = timeZone.identifier
        }
        
        timeZoneOffset.text = timeZone.abbreviation()
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
}
