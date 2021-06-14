//
//  WeatherModels.swift
//  Weather2021
//
//  Created by Igor Matsepura on 09.06.2021.
//

import Foundation
import UIKit


struct WeatherModel {
    
    var dt: Double
    var dtString: String {
        return "\(dt)"
    }
    var cityName: String
    var country: String
    var temperature: Double
    var temperatureString: String {
        return "\(temperature.rounded() - 273)"
    }
    let humidity: Int
    var humidityString: String {
        return "\(humidity)"
    }
    let pressure: Int
    var pressureString: String {
        return "\(pressure)"
    }
    let idIcon: Int
    var idIconString: String {
        return "\(idIcon)"
    }
    let main: String
    let clouds: Int
    var cloudsString: String {
        return (String(format: "%.1f", clouds))
    }
    let windSpeed: Double
    var windSpeedString: String {
        return "\(windSpeed)"
    }
    let windDeg: Int
    var windDegString: String {
        return "\(windDeg)"
    }
    let icon: String
    
    init(dt: Double, cityName: String, country: String, temperature: Double, humidity: Int, pressure: Int,
         idIcon: Int, main: String, clouds: Int, windSpeed: Double, windDeg: Int, icon: String ) {
        self.dt = dt
        self.cityName = cityName
        self.country = country
        self.temperature = temperature
        self.humidity = humidity
        self.pressure = pressure
        self.idIcon = idIcon
        self.main = main
        self.clouds = clouds
        self.windSpeed = windSpeed
        self.windDeg = windDeg
        self.icon = icon
        print("Init WeatherModels")
    }
    
    init?(dataCurrentWeather: DataCurrentWeather) {
        
        self.dt = dataCurrentWeather.list!.first!.dt!
        self.cityName = dataCurrentWeather.city!.name!
        self.country = dataCurrentWeather.city!.country!
        self.temperature = dataCurrentWeather.list!.first!.main!.temp!
        self.humidity = dataCurrentWeather.list!.first!.main!.humidity!
        self.pressure = dataCurrentWeather.list!.first!.main!.pressure!
        self.idIcon = dataCurrentWeather.list!.first!.weather!.first!.id!
        self.main = dataCurrentWeather.list!.first!.weather!.first!.main!
        self.clouds = dataCurrentWeather.list!.first!.clouds!.all!
        self.windSpeed = dataCurrentWeather.list!.first!.wind!.speed!
        self.windDeg = dataCurrentWeather.list!.first!.wind!.deg!
        self.icon = dataCurrentWeather.list!.first!.weather!.first!.icon!
        print(windSpeed)
    }
    
    var representation: [String: Any] {
        var rep = ["cityName": cityName]
        rep["dt"] = dtString
        rep["country"] = country
        rep["temperature"] = temperatureString
        return rep
    }
}
