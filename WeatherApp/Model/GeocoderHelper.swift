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
    
    func toLocation(_ city: String, completion: ((String?, CLLocation?) ->Void)?) {
        geocoder.geocodeAddressString(city) { places, _ in
            if let place = places?.first {
                if let coords = place.location?.coordinate {
                    var str = "?lat="
                    str += String(describing: coords.latitude)
                    str += "&lon="
                    str += String(describing: coords.longitude)
                    completion?(str, place.location)
                }
            }
        }
    }
    
    func toString(_ coords: CLLocation, completion: ((String) ->Void)?) {
        geocoder.reverseGeocodeLocation(coords) { places, _ in
            if let place = places?.first {
                completion?(place.locality ?? "")
            }
        }
    }
    
}
