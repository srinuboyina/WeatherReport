//
//  WeatherDetailsInteractorSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 22/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherDetailsInteractorSpec: XCTestCase {
    var interactor: WeatherDetailsInteractor!
    var presenterSpy: InteractorToPresenterWeatherDetailsProtocolSpy!
    override func setUp() {
        interactor = WeatherDetailsInteractor()
        presenterSpy = InteractorToPresenterWeatherDetailsProtocolSpy()
        interactor.presenter = presenterSpy
    }
    
    func testGetCurrentDayWeatherConditions() {
        interactor.getCurrentDayWeatherConditions(date: 1590094153, lat: 37.774929, long: -122.419418)
    }
    
    func testCreateURLFromParameters() {
        let url = interactor.createURLFromParameters(parameters: ["test": "test"])
        XCTAssertNotNil(url)
        XCTAssertTrue(url.absoluteString.contains("test"))
    }
}
