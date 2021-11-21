//
//  WeatherDetailsProtocol.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

protocol ViewToPresenterWeatherDetailsProtocol: class{
    
    var view: PresenterToViewWeatherDetailsProtocol? {get set}
    var interactor: PresenterToInteractorWeatherDetailsProtocol? {get set}
    var router: PresenterToRouterWeatherDetailsProtocol? {get set}
}

protocol PresenterToViewWeatherDetailsProtocol: class{

}

protocol PresenterToRouterWeatherDetailsProtocol: class {
    static func createModule()-> WeatherDetailsViewController
}

protocol PresenterToInteractorWeatherDetailsProtocol: class {
    var presenter:InteractorToPresenterWeatherDetailsProtocol? {get set}
}

protocol InteractorToPresenterWeatherDetailsProtocol: class {
}
