//
//  MovieInteractor.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class WeatherInteractor: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    func fetchWeatherReport(location: String) {
        if UserDefaults.standard.bool(forKey: "WeatherDataSaved") {
            let realm = try! Realm()
            let weatherObjs: Results<WeatherObject> = { realm.objects(WeatherObject.self) }()
            var weathers: [Weather] = []
            for weatherObject in weatherObjs {
                weathers.append(weatherObject.getWeather())
            }
            presenter?.weatherReportFetchedSuccess(weatherArray: weathers)
            
        } else {
            let queryParam = "?q=\(location)"
            if let url = URL(string: WeatherAPIInfo.weatherAPI + queryParam) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(WeatherAPIInfo.weatherAPIHost, forHTTPHeaderField: "x-rapidapi-host")
                request.setValue(WeatherAPIInfo.weatherAPIKey, forHTTPHeaderField: "x-rapidapi-key")
                URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    
                    if error == nil {
                        if let data = data {
                            let weatherReport = try? JSONDecoder().decode(WeatherReport.self, from: data)
                            var weathers: [Weather] = []
                            if let weatherReport = weatherReport {
                                for var weather in weatherReport.list {
                                    weather.lat = weatherReport.city.coord.lat
                                    weather.long = weatherReport.city.coord.lon
                                    weathers.append(weather)
                                }
                                self?.presenter?.weatherReportFetchedSuccess(weatherArray: weathers)
                            }
                        }
                        
                    } else {
                        self?.presenter?.weatherReporFetchFailed()
                    }
                    
                }.resume()
            }
        }
    }
    
}
