//
//  WeatherDetailsRouter.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailsRouter: PresenterToRouterWeatherDetailsProtocol {
    static func createModule() -> WeatherDetailsViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherDetailsViewController") as! WeatherDetailsViewController
        
        let presenter: ViewToPresenterWeatherDetailsProtocol & InteractorToPresenterWeatherDetailsProtocol = WeatherDetailsPresenter()
        let interactor: PresenterToInteractorWeatherDetailsProtocol = WeatherDetailsInteractor()
        let router:PresenterToRouterWeatherDetailsProtocol = WeatherDetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
}
