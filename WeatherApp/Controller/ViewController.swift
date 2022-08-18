//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var imageLbl: UIImageView!
    
    var lastKnownCoords: CLLocation?
    var forecasts: [Forecast] = []
    
    var manager: CLLocationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        setupFlowLayout()
    }
    
    func setupFirst() {
        containerView.layer.cornerRadius = 25
        containerView.backgroundColor = .systemMint
        imageLbl.image = nil
        descLbl.text = ""
        cityLbl.text = ""
        tempLbl.text = ""
        if let first = forecasts.first {
            cityLbl.textColor = .white
            ImadeDownloader().download(first.weather.first!.icon) { d in
                DispatchQueue.main.async {
                    if let data = d {
                        self.imageLbl.image = UIImage(data: data)
                    }
                }
            }
            descLbl.text = first.weather.first?.description
            tempLbl.text = "\(Int(first.main.temp))°C"
            if let last = lastKnownCoords {
                GeocoderHelper.shared.toString(last) { city in
                    DispatchQueue.main.async {
                        self.cityLbl.text = city
                        
                    }
                }

            }
        }
    }
    
    @IBAction func addCity(_ sender: Any) {
    }
    
    @IBAction func changeCity(_ sender: Any) {
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
        self.lastKnownCoords = loc
        let coords = loc.coordinate
        var str = "?lat="
        str += String(describing: coords.latitude)
        str += "&lon="
        str += String(describing: coords.longitude)
        APIHelper.shared.parseWeather(coords: str) { forecast in
            DispatchQueue.main.async {
                self.forecasts = forecast
                self.tableView.reloadData()
                self.collectionView.reloadData()
                self.setupFirst()
                
            }
        }
    }
    
    

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Daily") as? DailyCell {
            cell.setup(forecasts[indexPath.row])
            return cell
        }
        let cell = UITableViewCell()
        let forecast = forecasts[indexPath.row]
        var configuration = cell.defaultContentConfiguration()
        configuration.text = forecast.weather.first?.description ?? "Aucune donnée"
        cell.contentConfiguration = configuration
        return cell
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func setupFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 80)
        collectionView.collectionViewLayout = layout
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if forecasts.count < 8 {
            return forecasts.count
        }
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Hour", for: indexPath) as! HourCell
        cell.setup(forecasts[indexPath.item])
        return cell
    }
}
