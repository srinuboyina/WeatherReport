//
//  WeatherDetailsProtocol.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

protocol ViewToPresenterWeatherDetailsProtocol: class{
    
    var view: PresenterToViewWeatherDetailsProtocol? {get set}
    var interactor: PresenterToInteractorWeatherDetailsProtocol? {get set}
    var router: PresenterToRouterWeatherDetailsProtocol? {get set}
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double)
    func getValues(weather: Weather) -> Dictionary<String, String>
}

protocol PresenterToViewWeatherDetailsProtocol: class{
    func dayWeatherReportFetched(dayReport: CurrentDayWeather)
    func dayWeatherReportFailed()
}

protocol PresenterToRouterWeatherDetailsProtocol: class {
    static func createModule()-> WeatherDetailsViewController
}

protocol PresenterToInteractorWeatherDetailsProtocol: class {
    var presenter:InteractorToPresenterWeatherDetailsProtocol? {get set}
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double)
}

protocol InteractorToPresenterWeatherDetailsProtocol: class {
    func dayWeatherReportFetched(dayReport: CurrentDayWeather)
    func dayWeatherReportFailed()
}
