//
//  ForecastWeatherTable.swift
//  Weather2021
//
//  Created by Igor Matsepura on 12.06.2021.
//

import UIKit

struct weakDaysWeather {
    let country: String!
    let temperature: Int!
    let humidity: Int!
    let dayOfWeak: String!
    let sunny: UIImage!
}

class ForecastWeatherTable: UITableViewController {
    
    var weatherDataModel: WeatherModel?
    var managerFetch = ManagerFetch()
    var vc = ViewController()
    var iconManager = IconManager()
    
    var dataModelCell: DataCurrentWeather? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coordinateData { latitude, longitude in }
        navigationItem.title = dataModelCell?.city?.name ?? "N/A"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension ForecastWeatherTable {
    
    func coordinateData( completion: @escaping (Double? ,Double? ) -> ()) {
        let dataForecat = vc.locationManager.location
        let latitude = dataForecat?.coordinate.latitude
        let longitude = dataForecat?.coordinate.longitude
        //       completion(latitude, longitude)
        self.managerFetch.fetchTodayWeather(forLatitude: latitude!, forLongitude: longitude!, daysWeatherType: .giveFiveDayWeather) { [weak self] data in
            DispatchQueue.main.async {
                self?.giveData(with: data)
                self?.dataModelCell = data
            }
        }
    }
    
    func giveData(with weatherDataModel: DataCurrentWeather?) {
        
        guard let data = weatherDataModel else {
            debugPrint("No data")
            return
        }
        let weatherDataModel = WeatherModel(dataCurrentWeather: data)
        //self.test.text = weatherDataModel?.cityName    
        self.weatherDataModel? = weatherDataModel!
        //  print("weatherDataModel1 \(weatherDataModel?.cityName)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataModelCell?.list!.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let timeWeather = dayStringFromTime(unixTime: (Double)((dataModelCell?.list?.first?.dt)!))
        let dayNow = Date().weekdayNameFull
        
        if timeWeather == dayNow {
            let cell = Bundle.main.loadNibNamed("TodayWeatherCell", owner: self, options: nil)?.first as! TodayWeatherCell
            cell.dayWeaksLabel.text = dayNow
            
        }
        let cell = Bundle.main.loadNibNamed("ForecastWeatherCell", owner: self, options: nil)?.first as! ForecastWeatherCell
        let iconWeather = dataModelCell?.list![indexPath.row].weather?.first?.icon
        let weatherIcon = self.iconManager.iconWeather(stringIcon: iconWeather!)
        cell.weatherImageView.image = weatherIcon
        let timeInDayWeatherConverter = timeStringFromUnixTime(unixTime: (Double)((dataModelCell?.list![indexPath.row].dt)!))
        cell.timeLabel.text = timeInDayWeatherConverter
        cell.cloudyLabel.text = dataModelCell?.list![indexPath.row].weather?.first?.main
        cell.temperatureLabel.text = "\(String(Int((dataModelCell?.list![indexPath.row].main?.temp ?? 0 )) - 273)) º"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let timeWeather = dayStringFromTime(unixTime: (Double)((dataModelCell?.list?.first?.dt)!))
        let dayNow = Date().weekdayNameFull
        
        if timeWeather == dayNow {
            return 92
            
        } else if timeWeather != dayNow {
            return 44
        }
        else {
            return 92
        }
        
    }
    
    func dayStringFromTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: NSLocale.current.identifier) as Locale
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date as Date)
    }
    
    func timeStringFromUnixTime(unixTime: Double) -> String {
        let date = NSDate(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        // Returns date formatted as 12 hour time.
        dateFormatter.dateFormat = "HH:mm a"
        return dateFormatter.string(from: date as Date)
    }
}

extension Date {
    
    var weekdayName: String {
        let formatter = DateFormatter(); formatter.dateFormat = "E"
        return formatter.string(from: self as Date)
    }
    
    var weekdayNameFull: String {
        let formatter = DateFormatter(); formatter.dateFormat = "EEEE"
        return formatter.string(from: self as Date)
    }
}


/*  simple
 
         let date = Date(timeIntervalSince1970: 1623790800)
         let dateFormatter = DateFormatter()
         dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
         dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
         dateFormatter.timeZone = .current
         let localDate = dateFormatter.string(from: date)
         let dateNow = Date()
         let timeStamp = dateNow.timeIntervalSince1970
         debugPrint(timeStamp)
 */


//  let sectionDay = ["Monday" ,"Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
//  let dayOfCalendar = NSCalendar.current.component(.day, from: Date())


//   weatherDataModel = WeatherModel()
   
//        weakDay = [weakDaysWeather(country: "", temperature: 24, humidity: 1000, dayOfWeak: "Monday", sunny: #imageLiteral(resourceName: "11n")),
//                   weakDaysWeather(country: "Kirovohrad", temperature: 22, humidity: 1200, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "Cloudy")),
//                   weakDaysWeather(country: "Kirovohrad", temperature: 26, humidity: 900, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "09d")),
//                   weakDaysWeather(country: "Kirovohrad", temperature: 22, humidity: 1111, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "01d")),
//                   weakDaysWeather(country: "", temperature: 26, humidity: 1000, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "11d")),
//                   weakDaysWeather(country: "Kirovohrad", temperature: 22, humidity: 1000, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "Cloudy-1")),
//                   weakDaysWeather(country: "Kirovohrad", temperature: 28, humidity: 1000, dayOfWeak: "Sunday", sunny: #imageLiteral(resourceName: "02d"))]
