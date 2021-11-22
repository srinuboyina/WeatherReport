//
//  WeatherCell.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.shadowColor = UIColor.red.cgColor
        self.mainView.layer.shadowOpacity = 1
        self.mainView.layer.shadowOffset = CGSize.zero
        self.mainView.layer.shadowRadius = 5
    }
    
    func setData(weather: Weather) {
        if let date = weather.date {
            dateLabel.text = date
        } else {
            dateLabel.text = weather.dt.getDate()
        }
        let humidity = weather.humidity.roundToDecimal(2)
        let pressure = weather.pressure.roundToDecimal(2)
        let wind_speed = weather.wind_speed.roundToDecimal(2)
        
        temperatureLabel.text = "Humidity: \(humidity) \nPressure: \(pressure) \nWindSpeed: \(wind_speed)"
    }
}
