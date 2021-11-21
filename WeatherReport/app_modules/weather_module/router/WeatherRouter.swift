//
//  WeatherRouter.swift
//  WeatherReport
//
//  Created by Srinivas on 20/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit

class WeatherRouter: PresenterToRouterProtocol {
    static func createModule() -> WeatherViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = WeatherPresenter()
        let interactor: PresenterToInteractorProtocol = WeatherInteractor()
        let router:PresenterToRouterProtocol = WeatherRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToWeatherDetailsScreen(navigationConroller: UINavigationController) {
        
    }    
}
