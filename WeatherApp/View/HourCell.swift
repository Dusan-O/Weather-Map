//
//  HourCell.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import UIKit

class HourCell: UICollectionViewCell {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    var forecast: Forecast!
    
    func setup(_ newForecast: Forecast) {
        self.forecast = newForecast
        self.timeLbl.text = forecast.dt_txt
        self.tempLbl.text = "\(Int(forecast.main.temp))°C"
    }
}
