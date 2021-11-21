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
            if let url = URL(string: WeatherAPIInfo.WEATHER_API + queryParam) {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.setValue(WeatherAPIInfo.WEATHER_API_HOST, forHTTPHeaderField: "x-rapidapi-host")
                request.setValue(WeatherAPIInfo.WEATHER_API_KEY, forHTTPHeaderField: "x-rapidapi-key")
                URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                    
                    if error == nil {
                        if let data = data {
                            let weatherReport = try? JSONDecoder().decode(WeatherReport.self, from: data)
                            self?.presenter?.weatherReportFetchedSuccess(weatherArray: weatherReport?.list ?? [])
                        }
                        
                    } else {
                        self?.presenter?.weatherReporFetchFailed()
                    }
                    
                }.resume()
            }
        }
    }
    
}
