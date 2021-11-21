//
//  WeatherPresenterSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherPresenterSpec: XCTestCase {
    var presenter: WeatherPresenter!
    var interactorSpy: PresenterToInteractorProtocolSpy!
    var viewSpy: PresenterToViewProtocolSpy!
    var routerSpy: PresenterToRouterProtocolSpy!
    override func setUp() {
        super.setUp()
        presenter = WeatherPresenter()
        interactorSpy = PresenterToInteractorProtocolSpy()
        viewSpy = PresenterToViewProtocolSpy()
        routerSpy = PresenterToRouterProtocolSpy()
        presenter.view = viewSpy
        presenter.interactor = interactorSpy
        presenter.router = routerSpy
    }
    
    func testStartFetchingWeatherReport() {
        presenter.startFetchingWeatherReport(location: "hyderabad")
        XCTAssertTrue(interactorSpy.fetchWeatherReportCalled)
    }
    
    func testWeatherReportFetchedSuccess() {
        presenter.weatherReportFetchedSuccess(weatherArray: [])
        XCTAssertTrue(viewSpy.showWeatherReportCalled)
    }
    
    func testWeatherReporFetchFailed() {
        presenter.weatherReporFetchFailed()
        XCTAssertTrue(viewSpy.showErrorCalled)
    }
}
