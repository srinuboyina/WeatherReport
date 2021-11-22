//
//  WeatherDetailsInteractor.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

class WeatherDetailsInteractor: PresenterToInteractorWeatherDetailsProtocol {
    var presenter: InteractorToPresenterWeatherDetailsProtocol?
    
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double) {
        let params = ["lat": lat, "lon": long, "dt": date]
        let url = createURLFromParameters(parameters: params)
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(WeatherAPIInfo.weatherAPIHost, forHTTPHeaderField: "x-rapidapi-host")
        request.setValue(WeatherAPIInfo.weatherAPIKey, forHTTPHeaderField: "x-rapidapi-key")
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            
            if error == nil {
                if let data = data {
                    let dayWeatherReport = try? JSONDecoder().decode(CurrentDayWeather.self, from: data)
                    if let dayWeatherReport = dayWeatherReport {
                        self?.presenter?.dayWeatherReportFetched(dayReport: dayWeatherReport)
                    }
                }
                
            } else {
                self?.presenter?.dayWeatherReportFailed()
            }
            
        }.resume()
    }
    
    func createURLFromParameters(parameters: [String:Any]) -> URL {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "community-open-weather-map.p.rapidapi.com"
        components.path = "/onecall/timemachine"
        if !parameters.isEmpty {
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        return components.url!
    }
    
}
