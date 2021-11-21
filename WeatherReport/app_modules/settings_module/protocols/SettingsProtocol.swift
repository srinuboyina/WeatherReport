//
//  SettingsProtocol.swift
//  WeatherReport
//
//  Created by Srinivas on 21/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterSettingsProtocol: class{
    
    var view: PresenterToViewSettingsProtocol? {get set}
    var interactor: PresenterToInteractorSettingsProtocol? {get set}
    var router: PresenterToRouterSettingsProtocol? {get set}
    func updateTemperatureSettings(isFahrenheit: Bool)
}

protocol PresenterToViewSettingsProtocol: class{
    func displaySettings()
}

protocol PresenterToRouterSettingsProtocol: class {
    static func createModule()-> SettingsViewController
}

protocol PresenterToInteractorSettingsProtocol: class {
    var presenter:InteractorToPresenterSettingsProtocol? {get set}
}

protocol InteractorToPresenterSettingsProtocol: class {
   
}
