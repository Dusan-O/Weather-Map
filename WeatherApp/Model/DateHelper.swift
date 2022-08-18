//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Dusan Orescanin on 18/08/2022.
//

import Foundation

class DateHelper {
    
    static let shared = DateHelper()
    
    let formatter = DateFormatter()
    
    func convertToTime(_ int: Int) -> String {
        let date = Date(timeIntervalSince1970: Double(int))
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        let string = formatter.string(from: date)
        return string
    }
    
    func convertRegular(_ int: Int) -> String {
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: Date(timeIntervalSince1970: Double(int)))
}
    
}
