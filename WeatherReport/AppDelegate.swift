//
//  AppDelegate.swift
//  WeatherReport
//
//  Created by Srinivas on 19/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var timer: Timer?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let weather = WeatherRouter.createModule()
//        let navigationController = UINavigationController()
//        navigationController.viewControllers = [weather]
//        
//        let settingsViewController = SettingsRouter.createModule()
//        let settingsNavController = UINavigationController(rootViewController: settingsViewController)
//        
//        let tabBarController = UITabBarController()
//        tabBarController.viewControllers = [navigationController,settingsNavController]
//        /* Setting up the root view-controller as ui-navigation-controller */
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = tabBarController
//        window?.makeKeyAndVisible()
        timer = Timer(timeInterval: 3600, target: self, selector: #selector(getCurrentWeather), userInfo: nil, repeats: true)
        timer?.fire()
        return true
    }
    
    @objc func getCurrentWeather() {
        let location = UserDefaults.standard.string(forKey: "City") ?? "hyderabad"
        let queryParam = "?q=\(location)"
        if let url = URL(string: WeatherAPIInfo.weatherCurrentAPI + queryParam) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue(WeatherAPIInfo.weatherAPIHost, forHTTPHeaderField: "x-rapidapi-host")
            request.setValue(WeatherAPIInfo.weatherAPIKey, forHTTPHeaderField: "x-rapidapi-key")
            URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                if error == nil {
                    if let data = data {
                        let weatherReport = try? JSONDecoder().decode(CurrentWeather.self, from: data)
                        if let weatherReport = weatherReport {
                            DispatchQueue.main.async {
                                self?.fireLocalNotification(weatherReport: weatherReport.report)
                            }
                        }
                    }
                    
                } else {
                
                }
                
            }.resume()
        }
    }
    
    
    
    private func fireLocalNotification(weatherReport: String) {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(
            options: [.badge, .sound, .alert]) {
            [weak center] granted, _ in
            guard granted, let center = center
            else { return }
            let content = UNMutableNotificationContent()
            content.body = weatherReport
            let imageName = "logo"
            guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
            let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
            content.attachments = [attachment]
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0, repeats: false)
            let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
            center.add(request, withCompletionHandler: nil)
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
 }

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    }
}
