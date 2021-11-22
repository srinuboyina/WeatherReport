//
//  WeatherDetailsPresenterSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherDetailsPresenterSpec: XCTestCase {
    var presenter: WeatherDetailsPresenter!
    var viewSpy: PresenterToViewWeatherDetailsProtocolSpy!
    var routerSpy: PresenterToRouterWeatherDetailsProtocolSpy!
    var interactorSpy: PresenterToInteractorWeatherDetailsProtocolSpy!
    override func setUp() {
        super.setUp()
        viewSpy = PresenterToViewWeatherDetailsProtocolSpy()
        routerSpy = PresenterToRouterWeatherDetailsProtocolSpy()
        interactorSpy = PresenterToInteractorWeatherDetailsProtocolSpy()
        presenter = WeatherDetailsPresenter()
        interactorSpy.presenter = presenter
        presenter.view = viewSpy
        presenter.router = routerSpy
        presenter.interactor = interactorSpy
    }
    
    func testGetCurrentDayWeatherConditions() {
        presenter.getCurrentDayWeatherConditions(date: 1590094153, lat: 37.774929, long: -122.419418)
        XCTAssertTrue(interactorSpy.getCurrentDayWeatherConditionsCalled)
    }
    
    func testGetValues() {
        let temp = Temperature(average: 4.0, average_max: 5.0, average_min: 4.0, record_max: 6.0, record_min: 3.0)
        let weather = Weather(dt: 1590094153, date: "22/11/2021", humidity: 3.0, pressure: 5.0, temp: temp, wind_speed: 10.0)
        let values = presenter.getValues(weather: weather)
        XCTAssertTrue(values.count == 5)
    }
}
