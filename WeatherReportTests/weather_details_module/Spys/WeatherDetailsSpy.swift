//
//  WeatherDetailsSpy.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//


import Foundation
import XCTest
@testable import WeatherReport

class WeatherPresenterWeatherDetailsSpy: ViewToPresenterWeatherDetailsProtocol {
    var getCurrentDayWeatherConditionsCalled = false
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double) {
        getCurrentDayWeatherConditionsCalled = true
    }
    
    var getValuesCalled = false
    func getValues(weather: Weather) -> Dictionary<String, String> {
        getValuesCalled = true
        return [:]
    }
    
    var view: PresenterToViewWeatherDetailsProtocol?
    
    var interactor: PresenterToInteractorWeatherDetailsProtocol?
    
    var router: PresenterToRouterWeatherDetailsProtocol?
    
    var startFetchingWeatherReportCalled = false
    func startFetchingWeatherReport(location: String) {
        startFetchingWeatherReportCalled = true
    }
    
    var showWeatherDetailsControllerCalled = false
    func showWeatherDetailsController(navigationController: UINavigationController) {
        showWeatherDetailsControllerCalled = true
    }
}

class PresenterToViewWeatherDetailsProtocolSpy: PresenterToViewWeatherDetailsProtocol {
    var dayWeatherReportFetchedCalled = false
    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        dayWeatherReportFetchedCalled = true
    }
    
    var dayWeatherReportFailedCalled = false
    func dayWeatherReportFailed() {
        dayWeatherReportFailedCalled = true
    }
}

class PresenterToInteractorWeatherDetailsProtocolSpy: PresenterToInteractorWeatherDetailsProtocol {
    
    var getCurrentDayWeatherConditionsCalled = false
    func getCurrentDayWeatherConditions(date: Double, lat: Double, long: Double) {
        getCurrentDayWeatherConditionsCalled = true
    }
    
    var presenter: InteractorToPresenterWeatherDetailsProtocol?

    
    var fetchWeatherReportCalled = false
    func fetchWeatherReport(location: String) {
        fetchWeatherReportCalled = true
    }
 }

class InteractorToPresenterWeatherDetailsProtocolSpy: InteractorToPresenterWeatherDetailsProtocol {
    
    var dayWeatherReportFetchedCalled = false
    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        dayWeatherReportFetchedCalled = true
    }
    
    var dayWeatherReportFailedCalled = false
    func dayWeatherReportFailed() {
        dayWeatherReportFailedCalled = true
    }
    
    
    var weatherReportFetchedSuccessCalled = false
    func weatherReportFetchedSuccess(weatherArray: [Weather]) {
        weatherReportFetchedSuccessCalled = true
    }
    
    var weatherReporFetchFailedCalled = false
    func weatherReporFetchFailed() {
        weatherReporFetchFailedCalled = true
    }

}

class PresenterToRouterWeatherDetailsProtocolSpy: PresenterToRouterWeatherDetailsProtocol {
    static var createModuleCalled = false
    static func createModule() -> WeatherDetailsViewController {
        createModuleCalled = true
        return WeatherDetailsViewController()
    }
}
