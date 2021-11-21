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
    var showWeatherReportCalled = false
    func showWeatherReport(weatherArray: [Weather]) {
        showWeatherReportCalled = true
    }
    
    var showErrorCalled = false
    func showError() {
        showErrorCalled = true
    }
}

class PresenterToInteractorWeatherDetailsProtocolSpy: PresenterToInteractorWeatherDetailsProtocol {
    var presenter: InteractorToPresenterWeatherDetailsProtocol?

    
    var fetchWeatherReportCalled = false
    func fetchWeatherReport(location: String) {
        fetchWeatherReportCalled = true
    }
 }

class InteractorToPresenterWeatherDetailsProtocolSpy: InteractorToPresenterWeatherDetailsProtocol {
    
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
