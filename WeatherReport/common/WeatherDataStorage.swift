//
//  WeatherDataStorage.swift
//  WeatherReport
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import RealmSwift

class WeatherObject: Object {
    @objc dynamic var average = 0.0
    @objc dynamic var average_max = 0.0
    @objc dynamic var average_min = 0.0
    @objc dynamic var record_max = 0.0
    @objc dynamic var record_min = 0.0
    @objc dynamic var date: String!
    @objc dynamic var humidity = 0.0
    @objc dynamic var pressure = 0.0
    @objc dynamic var wind_speed = 0.0
    
    func getWeather() -> Weather {
        let temp = Temperature(average: average, average_max: average_max, average_min: average_min, record_max: record_max, record_min: record_min)
        let weather = Weather(date: date, humidity: humidity, pressure: pressure, temp: temp, wind_speed: wind_speed)
        return weather
    }
}

class WeatherDataStore {
    static func saveDataToDatabase(list: [Weather]) {
        DispatchQueue.global(qos: .background).async {
            let realm = try! Realm()
            try! realm.write() {
                for weather in list {
                    let newWeather = WeatherObject()
                    newWeather.date = weather.dt.getDate()
                    newWeather.humidity = weather.humidity
                    newWeather.pressure = weather.pressure
                    newWeather.wind_speed = weather.wind_speed
                    newWeather.average = weather.temp.average
                    newWeather.average_max = weather.temp.average_max
                    newWeather.average_min = weather.temp.average_min
                    newWeather.record_max = weather.temp.record_max
                    newWeather.record_min = weather.temp.record_min
                    realm.add(newWeather)
                }
                UserDefaults.standard.set(true, forKey: "WeatherDataSaved")
            }
        }
    }
}
