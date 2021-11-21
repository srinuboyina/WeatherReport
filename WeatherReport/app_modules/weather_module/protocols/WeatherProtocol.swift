//
//  WeatherProtocol.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingWeatherReport(location: String)
    func showWeatherDetailsController(navigationController:UINavigationController)

}

protocol PresenterToViewProtocol: class{
    func showWeatherReport(weatherArray:[Weather])
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> WeatherViewController
    func pushToWeatherDetailsScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchWeatherReport(location: String)
}

protocol InteractorToPresenterProtocol: class {
    func weatherReportFetchedSuccess(weatherArray:[Weather])
    func weatherReporFetchFailed()
}

