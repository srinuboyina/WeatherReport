//
//  WeatherDetailsViewController.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: ViewToPresenterWeatherDetailsProtocol?
    var weather: Weather?
    var keyValues: Dictionary<String, String> = Dictionary<String,String>()
    
    private let sectionInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 10.0, right: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Weather Details"
        if let weather = weather, let date = weather.dt, let lat = weather.lat, let long = weather.long {
            self.title = "Weather Details \(date.getDate())"
            presenter?.getCurrentDayWeatherConditions(date: date, lat: lat, long: long)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let weather = weather, let presenter = presenter {
            keyValues = presenter.getValues(weather: weather)
            collectionView.reloadData()
        }
    }
}

extension WeatherDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keyValues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let keyValue = keyValues[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WeatherDetailsCell", for: indexPath) as! WeatherDetailsCell
        cell.setData(name: keyValue.key, value: keyValue.value)
        return cell
    }
}

extension WeatherDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: 120, height: 100)
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

extension WeatherDetailsViewController: PresenterToViewWeatherDetailsProtocol {
    func dayWeatherReportFetched(dayReport: CurrentDayWeather) {
        
    }
    
    func dayWeatherReportFailed() {
        
    }
}
