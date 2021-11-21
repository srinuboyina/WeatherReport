//
//  WeatherRouterSpec.swift
//  WeatherReportTests
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import XCTest
@testable import WeatherReport

class WeatherRouterSpec: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func testCreateModule() {
        let view = WeatherRouter.createModule()
        XCTAssertTrue(view is WeatherViewController)
    }
}
