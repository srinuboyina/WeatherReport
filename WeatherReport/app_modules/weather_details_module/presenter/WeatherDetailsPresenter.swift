//
//  WeatherDetailsPresenter.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

class WeatherDetailsPresenter: ViewToPresenterWeatherDetailsProtocol {
    var view: PresenterToViewWeatherDetailsProtocol?
    
    var interactor: PresenterToInteractorWeatherDetailsProtocol?
    
    var router: PresenterToRouterWeatherDetailsProtocol?
}

extension WeatherDetailsPresenter: InteractorToPresenterWeatherDetailsProtocol {

}
