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

protocol ManagerFetchDelegate: class {
    func updateUI(_: ManagerFetch, with weatherDataModel: DataCurrentWeather)
}


class ManagerFetch {
    
    weak var delegate: ManagerFetchDelegate?
    var onCompletion: ((DataCurrentWeather) -> Void)?
    var weatherModel: [DataCurrentWeather]?
    
    fileprivate let appID = "c11d1c0c2b68e8e6dff40f23d780bc0e"
    
    enum DaysWeatherType {
        case dayTodayWeather
        case giveFiveDayWeather
    }
    
    func fetchTodayWeather(forLatitude latitude: CLLocationDegrees, forLongitude longitude: CLLocationDegrees, daysWeatherType: DaysWeatherType) {
        var urlString = ""
        switch daysWeatherType {
        case .dayTodayWeather:
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&exclude=hourly,daily&appid=\(appID)&cnt=1"
        case .giveFiveDayWeather:
            urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&exclude=daily&appid=\(appID)"
        }
        performRequest(withURLString: urlString)
        
    }
    
//    fileprivate func performRequest(withURLString urlString: String)  {
//        guard let url = URL(string: urlString) else { return }
//        Alamofire.request(url).responseJSON { response in
//            self.weatherModel = Mapper<DataCurrentWeather>().mapArray(JSONObject: response.result.value)
//            let weatherModels = self.weatherModel
//
//        }
//    }
    
    
    fileprivate func performRequest(withURLString urlString: String)  {
        guard let url = URL(string: urlString) else { return }
        Alamofire.request(url).responseObject { [unowned self]  (response: DataResponse<DataCurrentWeather>) in
            switch response.result {

            case .success(let modelRespone):
              //  dump(model)
                let weatherResponse = response.result.value
           //     print(weatherResponse?.city)

                if let list = weatherResponse?.list {
                    for forecastWeather in list {
         //               print(forecastWeather.main?.humidity)
                    }
                }
                self.delegate?.updateUI(self, with: modelRespone)

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
 
    
    //last wrk
//    fileprivate func performRequest(withURLString urlString: String)  {
//        guard let url = URL(string: urlString) else { return }
//        Alamofire.request(url).responseObject { [unowned self] (respone: DataResponse<DataCurrentWeather>) in
//            switch respone.result {
//            case .success(let model):
//                self.onCompletion?(model)
//
//                print(model.list?.first?.main?.humidity)
//                print("Out")
//                print(model.city?.name)
//                let name = model.city!.country!
//                print(name)
//                self.delegate?.updateUI(self, with: model)
//                print("Nice")
//
//              //  var modelWeather = WeatherModel(dt: model.list!.first!.dt!, cityName: <#T##String#>, country: <#T##String#>, temperature: <#T##Double#>, humidity: <#T##Int#>, pressure: <#T##Int#>, idIcon: <#T##Int#>, main: <#T##String#>, clouds: <#T##Int#>, windSpeed: <#T##Double#>, windDeg: <#T##Int#>)
////                let modelWeather = WeatherModel(dataCurrentWeather: model)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}
