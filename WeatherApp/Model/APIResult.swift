//
//  APIResult.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation

struct ApiResult: Decodable {
    var list: [Forecast]
}

struct Forecast: Decodable {
    var dt: Int
    var main: Main
    var weather: [Weather]
    var dt_txt: String
}

struct Main: Decodable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
}

struct Weather: Decodable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

/*

"visibility": 10000,
"pop": 0,
"sys": {
"pod": "n"
},
"dt_txt": "2022-08-18 12:00:00"
},
{
*/
