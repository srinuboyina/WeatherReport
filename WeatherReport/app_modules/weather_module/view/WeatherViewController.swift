//
//  ViewController.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit
import CoreLocation
import RealmSwift

class WeatherViewController: UIViewController {
    var presenter:ViewToPresenterProtocol?
    var weathers: [Weather] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        activityView.isHidden = false
        tableView.isHidden = true
        getCurrentLocation()
        if presenter == nil {
            presenter = WeatherPresenter()
            let interactor =  WeatherInteractor()
            interactor.presenter = presenter as? InteractorToPresenterProtocol
            presenter?.interactor = interactor
            presenter?.router = WeatherRouter()
            presenter?.view = self
        }
        self.presenter?.startFetchingWeatherReport(location: "hyderabad")
    }
    
    func getCurrentLocation() {
        let locationManager = CLLocationManager()
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension WeatherViewController: PresenterToViewProtocol {
    func showWeatherReport(weatherArray: [Weather]) {
        
        DispatchQueue.main.async { [weak self] in
            self?.activityView.isHidden = true
            self?.weathers = weatherArray
            if !UserDefaults.standard.bool(forKey: "WeatherDataSaved") {
                WeatherDataStore.saveDataToDatabase(list: weatherArray)
            }
            self?.tableView.isHidden = false
            self?.tableView.dataSource = self
            self?.tableView.delegate = self
            self?.tableView.reloadData()
        }
    }
    
    func showError() {
        let errorAlert = UIAlertController(title: "Error", message: "Error in fetching weather report", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(errorAlert, animated: true)
    }

}

extension WeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = weathers[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.detailTextLabel?.backgroundColor = .red
        var finalText = ""
        if let dt = weather.dt {
            finalText = dt.getDate()
        } else {
            finalText = weather.date ?? ""
        }
        cell?.textLabel?.text = finalText + "             \(weather.wind_speed.roundToDecimal(2))"
        cell?.detailTextLabel?.text = String(describing: weather.wind_speed)
        return cell!
    }
}

extension WeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weather = weathers[indexPath.row]
        let weatherDetailsView = WeatherDetailsRouter.createModule()
        weatherDetailsView.weather = weather
        self.navigationController?.pushViewController(weatherDetailsView, animated: true)
    }
    
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locValue.latitude , longitude: locValue.longitude)
        geoCoder.reverseGeocodeLocation(location, completionHandler: { [weak self] (placemarks, error) -> Void in
            
            if let placemarks = placemarks, placemarks.count > 0 {
                print("Response GeoLocation : \(placemarks)")
                var placeMark: CLPlacemark!
                placeMark = placemarks.first
                print("location is \(placeMark)")
                // City
                placeMark.dictionaryWithValues(forKeys: ["City"])
                if let city = placeMark.addressDictionary!["City"] as? String {
                    print("City :- \(city)")
                    UserDefaults.standard.set(city, forKey: "City")
                    self?.presenter?.startFetchingWeatherReport(location: city)
                }
            }
        })
    }
}
