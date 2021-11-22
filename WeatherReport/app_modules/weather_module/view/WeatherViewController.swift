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
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 10.0, right: 0.0)
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather"
        activityView.isHidden = false
        collectionView.isHidden = true
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
            self?.collectionView.isHidden = false
            self?.collectionView.dataSource = self
            self?.collectionView.delegate = self
            self?.collectionView.reloadData()
        }
    }
    
    func showError() {
        let errorAlert = UIAlertController(title: "Error", message: "Error in fetching weather report", preferredStyle: .alert)
        errorAlert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(errorAlert, animated: true)
    }

}

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let weather = weathers[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCell
        cell.setData(weather: weather)
        return cell
    }
}

extension WeatherViewController: UICollectionViewDelegateFlowLayout {
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 150, height: 100)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
}

extension WeatherViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
