//
//  ViewController.swift
//  WeatherApp
//
//  Created by Таня Кожевникова on 03.07.2025.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: IB-Outlets
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.layer.cornerRadius = 10
        
    }


}
