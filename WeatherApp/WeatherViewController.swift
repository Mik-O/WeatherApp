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
    
    @objc private func didTapGetWeatherButton() {
        let urlString =  "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current_weather=true"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data) {
                DispatchQueue.main.async {
                    self.temperatureLabel.text = "\(weather.currentWeather.temperature) °C"
                    print("Parsed")
                }
            } else {
                print("Fail")
            }
        }
        task.resume()
        
    }
}
