//
//  WeatherCell.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(weather: Weather) {
        let date = Date(timeIntervalSince1970: weather.dt)
        dateLabel.text = String(describing: date)
        
        var average = weather.temp.average
        var average_min = weather.temp.average_min
        var average_max = weather.temp.average_max
        var record_max = weather.temp.record_max
        var record_min = weather.temp.record_min
        
        if !UserDefaults.standard.bool(forKey: "Fahrenheit") {
            average = (weather.temp.average - 32) / 1.8
            average_max = (weather.temp.average_max - 32) / 1.8
            average_min = (weather.temp.average_min - 32) / 1.8
        }
        
        temperatureLabel.text = "\(average_max) \(average) \(average_min)"
    }
}
