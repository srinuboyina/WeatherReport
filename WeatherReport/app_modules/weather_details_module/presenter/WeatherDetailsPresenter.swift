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
}

extension WeatherDetailsPresenter: InteractorToPresenterWeatherDetailsProtocol {

    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        view?.dayWeatherReportFetched(dayReport: dayReport)
    }
    
    func dayWeatherReportFailed() {
        view?.dayWeatherReportFailed()
    }
}
