//
//  ViewController.swift
//  Weather2021
//
//  Created by Igor Matsepura on 08.06.2021.
//

import UIKit
import CoreLocation


class ViewController: UIViewController {

    
    
    @IBOutlet weak var imageIcon: UIImageView!
    @IBOutlet weak var cityCountryLbl: UILabel!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var sunnyLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var windSpeedLbl: UILabel!
    @IBOutlet weak var directionWind: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    
    
    var managerFetch = ManagerFetch()
    
    lazy var locationManager:CLLocationManager = {
        let locataionManagerCity = CLLocationManager()
        locataionManagerCity.delegate = self
        locataionManagerCity.desiredAccuracy = kCLLocationAccuracyKilometer
        locataionManagerCity.requestWhenInUseAuthorization()
        return locataionManagerCity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        managerFetch.delegate = self
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
     //   managerFetch.fetchTodayWeather(forLatitude: 48.507933, forLongitude: 32.262317, daysWeatherType: .giveFiveDayWeather)
    }
}

// MARK: - CLLocation delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
            
        managerFetch.fetchTodayWeather(forLatitude: latitude, forLongitude: longitude, daysWeatherType: .dayTodayWeather)
        print("This is \(latitude)")
        print("This is \(longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        if status == .denied {
            let message = """
                Your Location is requred to recive Weather data
                and will be activated ONLY after you provide
                GEOtify premission to access device location.
            """
            let ac = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            DispatchQueue.main.async(execute: {
                self.present(ac, animated: true, completion: nil)
            })
        }
    }
}

extension ViewController: ManagerFetchDelegate {
    func updateUI(_: ManagerFetch, with weatherDataModel: DataCurrentWeather) {

        let firstText = weatherDataModel.list!.first!
        let cityText = weatherDataModel.city!
        let windDirection = WindManagerWeather(Double(firstText.wind!.deg!))
        print(windDirection)
        DispatchQueue.main.async {
            self.cityCountryLbl.text = "\(String(describing: cityText.name!)), \(String(describing: cityText.country!))"
            self.temperatureLbl.text =  "\(String(Int((firstText.main!.temp!).rounded()) - 273)) ºC"
            self.sunnyLbl.text = firstText.weather!.first!.main
            self.humidityLbl.text = "\(String(firstText.main!.humidity!))%"
            self.mainLbl.text = "\(firstText.clouds!.all!) mm"
            self.pressureLbl.text = "\(String(firstText.main!.pressure!)) hPa"
            self.windSpeedLbl.text = "\(String(Int(firstText.wind!.speed!))) km/h"
            self.directionWind.text = "   \(windDirection)   "
            
        }
    }
    
}

