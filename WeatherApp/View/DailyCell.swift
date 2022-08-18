//
//  DailyCell.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var forecast: Forecast!
    
    func setup(_ newForecast: Forecast) {
        self.forecast = newForecast
        iconImage.image = nil
        tempLbl.text = "\(Int(forecast.main.temp))°C"
        timeLbl.text = DateHelper().convertRegular(forecast.dt)
        descLbl.text = forecast.weather.first!.description
        ImadeDownloader().download(forecast.weather.first!.icon) { data in
            DispatchQueue.main.async {
                if data != nil {
                    self.iconImage.image = UIImage(data: data!)
                }
            }
        }
        
    }
    
}
