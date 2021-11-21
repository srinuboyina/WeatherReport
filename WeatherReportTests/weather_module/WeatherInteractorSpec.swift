//
//  WeatherInteractorSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherInteractorSpec: XCTestCase {
    var interactor: WeatherInteractor!
    var presenterSpy: InteractorToPresenterProtocolSpy!
    override func setUp() {
        super.setUp()
        interactor = WeatherInteractor()
        presenterSpy = InteractorToPresenterProtocolSpy()
        interactor.presenter = presenterSpy
    }
    
    func testFetchWeatherReport() {
        interactor.fetchWeatherReport(location: "hyderabad")
        XCTAssert(presenterSpy.weatherReportFetchedSuccessCalled == true, "fetch success")
    }
}
