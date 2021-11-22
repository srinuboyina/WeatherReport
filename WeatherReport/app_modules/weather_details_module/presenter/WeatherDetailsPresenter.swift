//
//  WeatherDetailsPresenter.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

class WeatherDetailsPresenter: ViewToPresenterWeatherDetailsProtocol {
    
    var view: PresenterToViewWeatherDetailsProtocol?
    
    var interactor: PresenterToInteractorWeatherDetailsProtocol?
    
    var router: PresenterToRouterWeatherDetailsProtocol?
    
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double) {
        interactor?.getCurrentDayWeatherConditions(date: date, lat: lat, long: long)
    }
    
    func getValues(weather: Weather) -> Dictionary<String, String> {
        var keyValues: Dictionary<String, String> = Dictionary<String,String>()
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

        keyValues["Average"] = String(average!.roundToDecimal(2))
        keyValues["AverageMax"] = String(average_max!.roundToDecimal(2))
        keyValues["AverageMin"] = String(average_min!.roundToDecimal(2))
        keyValues["RecordMax"] = String(record_max!.roundToDecimal(2))
        keyValues["RecordMin"] = String(record_min!.roundToDecimal(2))
        return keyValues
    }
}

extension WeatherDetailsPresenter: InteractorToPresenterWeatherDetailsProtocol {

    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        view?.dayWeatherReportFetched(dayReport: dayReport)
    }
    
    func dayWeatherReportFailed() {
        view?.dayWeatherReportFailed()
    }
}
