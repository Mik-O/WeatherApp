//
//  MoreInfoWeatherViewController.swift
//  WeatherApp
//
//  Created by Таня Кожевникова on 04.07.2025.
//

import UIKit

class MoreInfoWeatherViewController: UITableViewController {
    
    var weatherModel: WeatherInfoModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        if let model = DataManager.shared.presentationModel {
            weatherModel = model.trasnformToData()
        }
}

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let weatherModel = weatherModel {
            return weatherModel.weatherData.count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        weatherModel?.weatherData[section].name
            }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if let weatherModel = weatherModel {
            let weather = weatherModel.weatherData[indexPath.section]
            if let value = weather.value {
                content.text = "\(value)"
            }
        }
        
        
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
}
