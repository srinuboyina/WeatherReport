//
//  Weather.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

struct WeatherReport: Codable {
    var cod: String!
    var message: Double!
    var city: City!
    var list: [Weather]!
    
    init(cod: String!, message: Double!, city: City!, list: [Weather]) {
        self.cod = cod
        self.message = message
        self.city = city
        self.list = list
    }
}

struct City: Codable {
    var id: Double!
    var name: String!
    var coord: Coordinate!
    var country: String!
}

struct Coordinate: Codable {
    var lat: Double!
    var lon: Double!
}

struct Weather: Codable {
    var dt: Double!
    var humidity: Double!
    var pressure: Double!
    var temp: Temperature!
    var wind_speed: Double!
    var date: String?
    var lat: Double!
    var long: Double!
    
    init(dt: Double!, date: String, humidity: Double!, pressure: Double!, temp: Temperature!, wind_speed: Double!) {
        self.dt = dt
        self.date = date
        self.humidity = humidity
        self.pressure = pressure
        self.temp = temp
        self.wind_speed = wind_speed
    }
}

struct Temperature: Codable {
    var average: Double!
    var average_max: Double!
    var average_min: Double!
    var record_max: Double!
    var record_min: Double!
    
    init(average: Double!, average_max: Double!, average_min: Double!, record_max: Double!, record_min: Double!) {
        self.average = average
        self.average_max = average_max
        self.average_min = average_min
        self.record_max = record_max
        self.record_min = record_min
    }
}

struct CurrentWeather: Codable {
    var coord : Coordinate!
    var weather: [CurrentWeatherPredictions]!
    var base: String!
    var visibility: Double
    var main: CurrentTemp!
    var wind: Wind
    var clouds: Clouds
    var dt: Double
    var report: String {
        get {
            if let weather = weather, weather.count > 0 {
                return   "\(weather.first!.main!) \(weather.first!.description!) \(main.feels_like.roundToDecimal(2))  humidity: \(main.humidity)"
            }
            return "\(main.feels_like.roundToDecimal(2))  humidity = \(main.humidity)"
        }
    }
}

struct CurrentWeatherPredictions: Codable {
    var id: Double
    var main: String!
    var description: String!
    var icon: String!
}

struct CurrentTemp: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
}

struct Wind: Codable {
    var speed: Double!
    var deg: Double!
}

struct Clouds: Codable {
    var all: Double!
}

