//
//  MeetViewController.swift
//  YourTime&Theirs
//
//  Created by Bharat Kumar on 10/30/20.
//  Copyright © 2020 Bharat Kumar. All rights reserved.
//

import UIKit

class MeetViewController: UIViewController {

    @IBOutlet weak var locationTimeLabel: UILabel!
    weak var delegate: TimeTableViewCell?
    
    var timer = Timer()
       
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
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
