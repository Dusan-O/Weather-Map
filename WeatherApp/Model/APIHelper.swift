//
//  APIHelper.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation

class APIHelper {
    
    static let shared = APIHelper()
    
    private let _apiKey = "2e297f571626b79e7827861f4f1b989f"
    
    let base = "https://api.openweathermap.org/data/2.5/forecast"
    let units = "&units=metric"
    let lang = "&lang=fr"
    var appID: String {
        return "&appid=" + _apiKey
    }
    
    func getUrl(coords: String) -> URL? {
        var urlString = base
        urlString += coords
        urlString += lang
        urlString += appID
        print(urlString)
        return URL(string: urlString)
    }
    
    func parseWeather(coords: String, completion: (([Forecast]) -> Void)?) {
        if let url = getUrl(coords: coords) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let d = data {
                    do {
                        let results = try JSONDecoder().decode(ApiResult.self, from: d)
                        completion?(results.list)
                    } catch {
                        print(error.localizedDescription)
                        completion?([])
                    }
                } else {
                    // completion
                }
            }.resume()
        } else {
            completion?([])
            
        }
    }
}
