//
//  UDHelper.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation

class UDHelper {
    
    static let shared = UDHelper()
    let key = "Cities"
    let getter = UserDefaults.standard
    
    func addDatas(_ string: String) {
        var array = getCities()
        array.append(string)
        getter.set(array, forKey: key)
    }
    
    func getCities() ->[String] {
        return getter.array(forKey: key) as? [String] ?? []
    }
}
