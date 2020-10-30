//
//  CountryViewController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/29/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit
import CCWATextField
import SKCountryPicker
class CountryViewController: UIViewController {

    @IBOutlet weak var pickCountryButton: UIButton!
    
    @IBOutlet weak var countryPickerView: CountryPickerView!
    
    @IBOutlet weak var chooseCountryLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupStoryboardPickerViewCallback()
        // Do any additional setup after loading the view.
    }
    

    

    @IBAction func nextTapped(_ sender: Any) {
        performSegue(withIdentifier: "TimeZoneSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "TimeZoneSegue" {
            guard let detailVC = segue.destination as? TimeZoneViewController else { return }
          
            detailVC.detailVC = self
        }
    }

 
    private func setupStoryboardPickerViewCallback() {
      countryPickerView.onSelectCountry { [weak self] (country) in
            guard let self = self,
                let digitCountrycode = country.digitCountrycode else {
                return
            }
            let text = "\(country.countryName)"
            self.chooseCountryLabel.text = text
        }
    }
}
