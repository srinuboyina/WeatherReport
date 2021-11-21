//
//  SettingsRouter.swift
//  WeatherReport
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit

class SettingsRouter: PresenterToRouterSettingsProtocol {
    static func createModule() -> SettingsViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        let presenter: ViewToPresenterSettingsProtocol & InteractorToPresenterSettingsProtocol = SettingsPresenter()
        let interactor: PresenterToInteractorSettingsProtocol = SettingsInteractor()
        let router:PresenterToRouterSettingsProtocol = SettingsRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

}
