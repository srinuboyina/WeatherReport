//
//  SettingsViewController.swift
//  WeatherReport
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var presenter: ViewToPresenterSettingsProtocol?

    @IBOutlet weak var radioButton1: KGRadioButton!
    @IBOutlet weak var radioButton2: KGRadioButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displaySettings()
    }
    
    @IBAction func radioButton1Clicked(sender: Any) {
        radio1Selected()
    }
    
    private func radio1Selected() {
        if !radioButton1.isSelected {
            radioButton1.isSelected = true
            radioButton2.isSelected = false
            UserDefaults.standard.set(true, forKey: "Fahrenheit")
        }
    }

    @IBAction func radioButton2Clicked(sender: Any) {
        radio2Selected()
    }
    
    private func radio2Selected() {
        if !radioButton2.isSelected {
            radioButton2.isSelected = true
            radioButton1.isSelected = false
            UserDefaults.standard.set(false, forKey: "Fahrenheit")
        }
    }

}

extension SettingsViewController: PresenterToViewSettingsProtocol {
    func displaySettings() {
        let isFahrenheit =  UserDefaults.standard.bool(forKey: "Fahrenheit")
        if isFahrenheit {
            radioButton1.isSelected = true
            radioButton2.isSelected = false
        } else {
            radioButton1.isSelected = false
            radioButton2.isSelected = true
        }
    }
}

