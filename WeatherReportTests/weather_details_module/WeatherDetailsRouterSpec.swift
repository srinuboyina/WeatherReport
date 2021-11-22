//
//  WeatherRouterSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 22/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherDetailsRouterSpec: XCTestCase {

    override func setUp() {
    }
    
    func testCreateModuler() {
        let view = WeatherDetailsRouter.createModule()
        XCTAssertTrue(view is WeatherDetailsViewController)
    }
}
