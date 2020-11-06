//
//  TimeZoneViewController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit

protocol TimeZoneDelegateText {
    var timeZoneString: String? { get set }
}
class TimeZoneViewController: UIViewController, TimeZoneDelegateText, TimeZonePickerDelegate {
    var timeZoneString: String?
 
    @IBOutlet weak var timeZoneName: UILabel!
    @IBOutlet weak var timeZoneOffset: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    var detailVC: CountryViewController?
    
    
    
    var timeZoneAdd: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isHidden = true
        timeZoneName.text = "Hi There"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func choosePickerTapped(_ sender: Any) {
        nextButton.isHidden = false
        
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
      performSegue(withIdentifier: "EventSegue", sender: self)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EventSegue" {

            guard let navVc = segue.destination as? UINavigationController,
                let detailVC = navVc.viewControllers.first as? EventTableViewController else { return }
            detailVC.timeZoneString = self.timeZoneOffset.text

         

        }
    }
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) -> String {
        if timeZoneName.text == detailVC?.chooseCountryLabel.text {
            timeZoneName.text = timeZone.identifier
        } else {
            timeZoneName.text = timeZone.identifier
        }
     
        timeZoneString = timeZone.abbreviation()
        timeZoneOffset.text = timeZoneString
        
        
        timeZonePicker.dismiss(animated: true, completion: nil)
        return timeZoneOffset.text!
    }
    
    
}
