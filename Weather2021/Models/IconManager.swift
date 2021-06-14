//
//  IconManager.swift
//  Weather2021
//
//  Created by Igor Matsepura on 14.06.2021.
//

import Foundation
import UIKit


class IconManager {
    
    func iconWeather(stringIcon: String) -> UIImage {
        
        let imagesName: String
        
        switch stringIcon {
        case "01d": imagesName = "01d"         //clear sky
        case "02d": imagesName = "02d"         //few clouds
        case "03d": imagesName = "03d_cloudy"         //scattered clouds
        case "04d": imagesName = "04d"         //scattered clouds
        case "09d": imagesName = "09d"         //scattered clouds
        case "10d": imagesName = "10d"         //rain
        case "11d": imagesName = "11d"         //thunderstorm
        case "13d": imagesName = "13d"         //snow
        case "50d": imagesName = "50d"         //mist
        case "01n": imagesName = "01n"         //night clear sky
        case "02n": imagesName = "02n"         //night few clouds
        case "03n": imagesName = "03n"         //night scattered clouds
        case "04n": imagesName = "04n"         //night scattered clouds
        case "09n": imagesName = "09n"         //night scattered clouds
        case "10n": imagesName = "10n"         //night rain
        case "11n": imagesName = "11n"         //night thunderstorm
        case "13n": imagesName = "13n"         //night snow
        case "50n": imagesName = "50n"         //night mist
        default: imagesName = "na"
        }
        
        let iconImage = UIImage(named: imagesName)
        return iconImage!
    }
}
