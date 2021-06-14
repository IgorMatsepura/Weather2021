//
//  DataCurrentWeather.swift
//  Weather2021
//
//  Created by Igor Matsepura on 09.06.2021.
//

import Foundation
import AlamofireObjectMapper
import ObjectMapper


class DataCurrentWeather: Mappable {
    
    var cod: String?
    var list: [List]?
    var city: City?
    
 
    func mapping(map: Map) {
        cod <- map["cod"]
        list <- map["list"]
        city <- map["city"]
    }
    
    required init?(map: Map) {
    
    }
}

class List: Mappable {
    
    var dt: Double?
    var main: Main?
    var weather:[Weather]?
    var wind: Wind?
    var clouds: Clouds?
    var dtTxt: String?
//    
//    enum CodingKeys: String, CodingKey {
//        case dt, main, weather, wind, clouds
//        case dtTxt = "dt_txt"
//    }
//    
    func mapping(map: Map) {
        dt <- map["dt"]
        main <- map["main"]
        weather <- map["weather"]
        wind <- map["wind"]
        clouds <- map["clouds"]
        dtTxt <- map["dtTxt"]
    }
    
    required init?(map: Map) {
    }
}

class Main: Mappable {

    var temp: Double?
    var pressure: Int?
    var humidity: Int?
    
    func mapping(map: Map) {
        temp <- map["temp"]
        pressure <- map["pressure"]
        humidity <- map["humidity"]
    }
    
    required init?(map: Map) {
    }
}

class Weather: Mappable {
    
    var id: Int?
    var main: String?
    var icon: String?
    
    func mapping(map: Map) {
        id <- map["id"]
        main <- map["main"]
        icon <- map["icon"]
    }
    
    required init?(map: Map) {
    }
}

class Wind: Mappable {
    
       var speed: Double?
       var deg: Int?
    
    func mapping(map: Map) {
        speed <- map["speed"]
        deg <- map["deg"]
    }
    
    required init?(map: Map) {
    }
}

class Clouds: Mappable {
    
    var all: Int?
    
    func mapping(map: Map) {
        all <- map["all"]
    }
    
    required init?(map: Map) {
    }
}
//
class City: Mappable {
    var name: String?
    var country: String?
    
    func mapping(map: Map) {
        name <- map["name"]
        country <- map["country"]
    }
   
    required init?(map: Map) {
    }
}
