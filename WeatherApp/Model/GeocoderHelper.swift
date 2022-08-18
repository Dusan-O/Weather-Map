//
//  GeocoderHelper.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation
import CoreLocation

class GeocoderHelper {
    
    static let shared = GeocoderHelper()
    let geocoder = CLGeocoder()
    
    func toString(_ coords: CLLocation, completion: ((String) ->Void)?) {
        geocoder.reverseGeocodeLocation(coords) { places, _ in
            if let place = places?.first {
                completion?(place.locality ?? "")
            }
        }
    }
    
}
