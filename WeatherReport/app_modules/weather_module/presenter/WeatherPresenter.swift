//
//  WeatherPresenter.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class WeatherPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
        
    func showWeatherDetailsController(navigationController: UINavigationController) {
        router?.pushToWeatherDetailsScreen(navigationConroller:navigationController)
    }
    
    func startFetchingWeatherReport(location: String) {
        interactor?.fetchWeatherReport(location: location)
    }
}

extension WeatherPresenter: InteractorToPresenterProtocol{
    
    func weatherReportFetchedSuccess(weatherArray:[Weather]) {
        view?.showWeatherReport(weatherArray: weatherArray)
    }
    
    func weatherReporFetchFailed() {
        view?.showError()
    }
}

