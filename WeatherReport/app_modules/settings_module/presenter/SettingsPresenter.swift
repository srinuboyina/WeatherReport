//
//  SettingsPresenter.swift
//  WeatherReport
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation

class SettingsPresenter: ViewToPresenterSettingsProtocol {
    var view: PresenterToViewSettingsProtocol?
    
    var interactor: PresenterToInteractorSettingsProtocol?
    
    var router: PresenterToRouterSettingsProtocol?
    
    func updateTemperatureSettings(isFahrenheit: Bool) {
        
    }
}

extension SettingsPresenter: InteractorToPresenterSettingsProtocol {

}
