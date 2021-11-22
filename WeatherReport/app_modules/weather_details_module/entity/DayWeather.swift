//
//  DayWeather.swift
//  WeatherReport
//
//  Created by Srinivas on 22/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

struct CurrentDayWeather: Codable {
    var current: DayWeather!
}

struct DayWeather: Codable {
    var dew_point: Double!
    var feels_like: Double!
    var sunrise: Double!
    var sunset: Double!
    var uvi: Double!
    var weather: [CurrentWeatherPredictions]
}

