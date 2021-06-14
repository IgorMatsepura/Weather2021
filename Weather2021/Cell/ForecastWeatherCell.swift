//
//  ForecastWeatherCell.swift
//  Weather2021
//
//  Created by Igor Matsepura on 12.06.2021.
//

import UIKit

class ForecastWeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var cloudyLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
