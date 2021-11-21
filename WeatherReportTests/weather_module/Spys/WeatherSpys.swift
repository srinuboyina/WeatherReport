//
//  WeatherPresenterSpy.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherPresenterSpy: ViewToPresenterProtocol {
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    var startFetchingWeatherReportCalled = false
    func startFetchingWeatherReport(location: String) {
        startFetchingWeatherReportCalled = true
    }
    
    var showWeatherDetailsControllerCalled = false
    func showWeatherDetailsController(navigationController: UINavigationController) {
        showWeatherDetailsControllerCalled = true
    }
}

class PresenterToViewProtocolSpy: PresenterToViewProtocol {
    var showWeatherReportCalled = false
    func showWeatherReport(weatherArray: [Weather]) {
        showWeatherReportCalled = true
    }
    
    var showErrorCalled = false
    func showError() {
        showErrorCalled = true
    }
}

class PresenterToInteractorProtocolSpy: PresenterToInteractorProtocol {
    var presenter: InteractorToPresenterProtocol?
    
    var fetchWeatherReportCalled = false
    func fetchWeatherReport(location: String) {
        fetchWeatherReportCalled = true
    }
 }

class InteractorToPresenterProtocolSpy: InteractorToPresenterProtocol {
    
    var weatherReportFetchedSuccessCalled = false
    func weatherReportFetchedSuccess(weatherArray: [Weather]) {
        weatherReportFetchedSuccessCalled = true
    }
    
    var weatherReporFetchFailedCalled = false
    func weatherReporFetchFailed() {
        weatherReporFetchFailedCalled = true
    }

}

class PresenterToRouterProtocolSpy: PresenterToRouterProtocol {
    static var createModuleCalled = false
    static func createModule() -> WeatherViewController {
        createModuleCalled = true
        return WeatherViewController()
    }
    
    var pushToWeatherDetailsScreenCalled = false
    func pushToWeatherDetailsScreen(navigationConroller:UINavigationController) {
        pushToWeatherDetailsScreenCalled = true
    }
}
