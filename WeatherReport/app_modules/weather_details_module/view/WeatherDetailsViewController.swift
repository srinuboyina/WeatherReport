//
//  WeatherDetailsViewController.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var averageMinLabel: UILabel!
    @IBOutlet weak var averageMaxLabel: UILabel!
    @IBOutlet weak var recordMaxLabel: UILabel!
    @IBOutlet weak var recordMinLabel: UILabel!
    
    var presenter: ViewToPresenterWeatherDetailsProtocol?
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Details"
        if let weather = weather, let date = weather.dt, let lat = weather.lat, let long = weather.long {
            presenter?.getCurrentDayWeatherConditions(date: date, lat: lat, long: long)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let weather = weather {
            var average = weather.temp.average
            var average_min = weather.temp.average_min
            var average_max = weather.temp.average_max
            var record_max = weather.temp.record_max
            var record_min = weather.temp.record_min
            
            if !UserDefaults.standard.bool(forKey: "Fahrenheit") {
                average = (weather.temp.average - 32) / 1.8
                average_max = (weather.temp.average_max - 32) / 1.8
                average_min = (weather.temp.average_min - 32) / 1.8
                record_max = (weather.temp.record_max - 32) / 1.8
                record_min = (weather.temp.record_min - 32) / 1.8
            }
            windSpeedLabel.text = String(weather.wind_speed!.roundToDecimal(2))
            averageLabel.text = String(describing: average!.roundToDecimal(2))
            averageMinLabel.text = String(describing: average_min!.roundToDecimal(2))
            averageMaxLabel.text = String(describing: average_max!.roundToDecimal(2))
            recordMinLabel.text = String(describing: record_min!.roundToDecimal(2))
            recordMaxLabel.text = String(describing: record_max!.roundToDecimal(2))
        }
    }
}

extension WeatherDetailsViewController: PresenterToViewWeatherDetailsProtocol {
    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        
    }
    
    func dayWeatherReportFailed() {
        
    }
}
