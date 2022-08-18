//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var forecasts: [Forecast] = []
    
    var manager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
    }


}

extension ViewController: CLLocationManagerDelegate {
    
    func setupLocation() {
        manager.delegate = self
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let loc = locations.first else { return }
        let coords = loc.coordinate
        var str = "?lat="
        str += String(describing: coords.latitude)
        str += "&lon="
        str += String(describing: coords.longitude)
        APIHelper.shared.parseWeather(coords: str) { forecast in
            DispatchQueue.main.async {
                self.forecasts = forecast
            }
        }
    }
}
