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
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
    }
    
    @objc func didTapGetWeatherButton() {
        let urlString =  "https://api.weatherapi.com/v1/current.json?key=e5d3d1af10274bc8aef142538250307&q=Novosibirsk&aqi=no"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.cityLabel.text = "\(weather.location.name)"
                    self.temperatureLabel.text = "\(weather.current.tempC) °C"
                    print("Parsed")
                }
            } else {
                print("Fail")
            }
        }
        task.resume()
        
    }
}
