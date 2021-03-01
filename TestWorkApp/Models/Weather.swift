//
//  Weather.swift
//  TestWorkApp
//
//  Created by Евгений Прохоров on 01.03.2021.
//

import Foundation

struct Weather: Codable {
    let name: String?
    let lat: String?
    let lon: String?
    let temp: String?
    
    init(weatherData: [String: Any]) {
        name = weatherData["name"] as? String
        lat = weatherData["lat"] as? String
        lon = weatherData["lon"] as? String
        temp = weatherData["temp"] as? String
    }
    
    static func getWeather(from value: Any) -> [Weather] {
        guard let weatherData = value as? [[String: Any]] else { return [] }
        return weatherData.compactMap { Weather(weatherData: $0) }
    }
}
