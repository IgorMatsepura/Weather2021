//
//  WindManagerWeather.swift
//  Weather2021
//
//  Created by Igor Matsepura on 11.06.2021.
//


import Foundation

// MARK: determine the wind direction from degrees to string

enum WindManagerWeather: String {
    case N, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, NW
}


extension WindManagerWeather: CustomStringConvertible {
    
    static let directionWind: [WindManagerWeather] = [.N, .nne, .ne, .ene, .e, .ese, .se, .sse, .s, .ssw, .sw, .wsw, .w, .wnw, .nw, .NW]
    
    init(_ direction: Double) {
        let index = Int((direction + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)
                        self = WindManagerWeather.directionWind[index]
    }
    
    var description: String {
        return rawValue.uppercased()
    }
}

extension Double {
    var direction: WindManagerWeather {
        return WindManagerWeather(self)
    }
}

