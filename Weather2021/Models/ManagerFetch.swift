//
//  ManagerFetch.swift
//  Weather2021
//
//  Created by Igor Matsepura on 09.06.2021.
//

import Foundation
import Alamofire
import CoreLocation
import ObjectMapper

//protocol ManagerFetchDelegate: class {
//    func updateUI(_: ManagerFetch, with weatherDataModel: DataCurrentWeather)
//}


class ManagerFetch {
    
//    weak var delegate: ManagerFetchDelegate?
//    var onCompletion: ((DataCurrentWeather) -> Void)?
//    var weatherModel: [DataCurrentWeather]?
    
    fileprivate let appID = "c11d1c0c2b68e8e6dff40f23d780bc0e"
    
    enum DaysWeatherType {
        case giveTodayWeather
        case giveFiveDayWeather
    }
    
    func fetchTodayWeather(forLatitude latitude: CLLocationDegrees, forLongitude longitude: CLLocationDegrees, daysWeatherType: DaysWeatherType, callback: @escaping (_ weatherDataModel: DataCurrentWeather?) -> Void) {
        var urlString = ""
        switch daysWeatherType {
        case .giveTodayWeather:
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&exclude=hourly,daily&appid=\(appID)&cnt=1"
        case .giveFiveDayWeather:
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&exclude=daily&appid=\(appID)"
        }
        performRequest(withURLString: urlString, callback: callback)
    }
    
    
    fileprivate func performRequest(withURLString urlString: String , callback: @escaping (_ weatherDataModel: DataCurrentWeather?) -> Void)  {
        guard let url = URL(string: urlString) else { return }
        Alamofire.request(url).responseObject { (response: DataResponse<DataCurrentWeather>) in
            switch response.result {
            
            case .success(_):
                //  dump(model)
                let weatherResponse = response.result.value
                callback(weatherResponse)
                //self.delegate?.updateUI(self, with: modelRespone)
            case .failure(let error):
                callback(nil)
                print(error.localizedDescription)
            }
        }
    }
}
