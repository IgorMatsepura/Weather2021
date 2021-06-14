//
//  ViewController.swift
//  Weather2021
//
//  Created by Igor Matsepura on 08.06.2021.
//

import UIKit
import CoreLocation

import Firebase
import FirebaseFirestore
import FirebaseAuth



class ViewController: UIViewController {

    let db = Firestore.firestore()
    
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
    var iconManager = IconManager()
    
    lazy var locationManager:CLLocationManager = {
        let locataionManagerCity = CLLocationManager()
        locataionManagerCity.delegate = self
        locataionManagerCity.desiredAccuracy = kCLLocationAccuracyKilometer
        locataionManagerCity.requestWhenInUseAuthorization()
        return locataionManagerCity
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
      //      self.forecastManager.navigationItem.title = self.cityCountryLbl.text
        }
    }
}

// MARK: - CLLocation delegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        managerFetch.fetchTodayWeather(forLatitude: latitude, forLongitude: longitude, daysWeatherType: .giveTodayWeather) { [weak self] data in
            DispatchQueue.main.async {
                self?.updateUI(with: data)
                
            }
        }
        //completion(latitude, longitude)
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

extension ViewController  {
    
    
    func updateUI(with weatherDataModel: DataCurrentWeather?) {
        
        guard let data = weatherDataModel else {
            debugPrint("No data")
            return
        }
        
        guard let firstText = data.list?.first,
              let cityText = data.city,
              let degree = firstText.wind?.deg  else {
            debugPrint("Not enough data")
            return
        }
        
        let windDirection = WindManagerWeather(Double(degree))
        print(windDirection)
        self.cityCountryLbl.text = "\(String(describing: cityText.name ?? "Data Empty")), \(String(describing: cityText.country ?? "N / A"))"
        self.sunnyLbl.text = firstText.weather!.first?.main ?? "N/A"
        self.temperatureLbl.text =  "\(String(Int((firstText.main?.temp ?? 0)) - 273)) ºC"
        self.humidityLbl.text = "\(String(firstText.main?.humidity ?? 0))%"
        self.mainLbl.text = "\(String(describing: firstText.clouds?.all ?? 0)) mm"
        self.pressureLbl.text = "\(String(firstText.main?.pressure ?? 0)) hPa"
        self.windSpeedLbl.text = "\(String(Int(firstText.wind?.speed ?? 0))) km/h"
        self.directionWind.text = "\(windDirection)"
        let iconWeather = firstText.weather?.first?.icon
        let weatherIcon = self.iconManager.iconWeather(stringIcon: iconWeather!)
        imageIcon.image = weatherIcon
        saveToFirebase(with: data)
    }
    
    func saveToFirebase(with weatherDataModel: DataCurrentWeather?) {
        
        guard let data = weatherDataModel else {
            debugPrint("Smth went wrong")
            return
        }
        
        let weatherModelForFirebase = WeatherModel(dataCurrentWeather: data)
        let userRef = db.collection("city")
        
        Auth.auth().signInAnonymously { (result, error) in
            let newCityRef = userRef.document()
            let idFireBase = newCityRef.documentID
            userRef.document(idFireBase).setData(weatherModelForFirebase!.representation) { (error) in    
            }
        }
    }
}

