//
//  FireBase.swift
//  Weather2021
//
//  Created by Igor Matsepura on 10.06.2021.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class RegisterCityWeather {
    
    private let auth = Auth.auth()
    static let shared = RegisterCityWeather()
    let db = Firestore.firestore()
    
    func saveData(city: String, dt: String?, country: String?, temperatureString:String?,
                  completion: @escaping (Result<WeatherModel, Error>) -> Void) {
        auth.signInAnonymously { (result, error) in
           // let refDb = self.db.collection("CityWeather")
            
            
            let saveModel = WeatherModel(dt: 90, cityName: "Kiev", country: "UA", temperature: 38.2, humidity: 1111, pressure: 60, idIcon: 500, main: "Rain", clouds: 8, windSpeed: 12.3, windDeg: 260)
            
            self.db.collection("City").document(saveModel.cityName).setData(saveModel.representation) { [weak self] (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(saveModel.country)
                }
            }
        }
    }
}

extension RegisterCityWeather: ManagerFetchDelegate {
    func updateUI(_: ManagerFetch, with weatherDataModel: DataCurrentWeather) {
        if let list = weatherDataModel.list {
            for forecastWeather in list {
                print(forecastWeather.main?.humidity)
            }
            let customMap = weatherDataModel.list?.first
            let wind = customMap!.wind
            let clouds = weatherDataModel.list?.first?.clouds
            let main = weatherDataModel.list?.first?.main
            let weather = weatherDataModel.list?.first?.weather?.first
            
            let weatherModel = WeatherModel?.self
            
            let saveModel = WeatherModel(dt: 90, cityName: "Kiev", country: "UA", temperature: 38.2, humidity: 1111, pressure: 60, idIcon: 500, main: "Rain", clouds: 8, windSpeed: 12.3, windDeg: 260)
            
            self.db.collection("City").document(saveModel.cityName).setData(saveModel.representation) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print(saveModel.country)
                }
            }
//            let saveModel = WeatherModel.init(dt: (list.first?.dt)!, cityName: (weatherDataModel.city?.name)!,
//                                              country: (weatherDataModel.city?.country)!, temperature: (main?.temp)!,
//                                              humidity: (main?.humidity)!, pressure: (main?.pressure)!, idIcon: weather?.id,
//                                              main: weather?.main, clouds: clouds?.all, windSpeed: wind?.speed, windDeg: wind?.deg)


        }
    }
    
    
}


