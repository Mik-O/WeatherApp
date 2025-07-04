// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? JSONDecoder().decode(Weather.self, from: jsonData)

import Foundation


// MARK: - WeatherData
struct WeatherData: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: String
    let pressureMB: Int
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Int
    let feelslikeC: Double
    let feelslikeF, windchillC, windchillF, heatindexC: Double
    let heatindexF, dewpointC, dewpointF: Double
    let visKM, visMiles: Int
    let uv, gustMph, gustKph: Double
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String
    let code: Int
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
}

// MARK: - Presentation Model
struct PresentationModel {
    let location: String
    let temperature: Double
    let windSpeed: Double
    let pressure: Double
    let condition: Condition
}

extension PresentationModel {
    
    func trasnformToData() -> WeatherInfoModel {
        let param1 = WeatherDataObject(name: nil, value: nil, condition: self.condition)
        let param2 = WeatherDataObject(name: "Temperature", value: self.temperature, condition: nil)
        let param3 = WeatherDataObject(name: "Wind Speed", value: self.windSpeed, condition: nil)
        let param4 = WeatherDataObject(name: "Pressure", value: self.pressure, condition: nil)
        let weatherData = [param1, param2, param3, param4]
        
        let weatherInfoModel = WeatherInfoModel(weatherData: weatherData)
        
        return weatherInfoModel
    }
}

struct WeatherInfoModel {
    var weatherData: [WeatherDataObject]
}

struct WeatherDataObject {
    let name: String?
    let value: Double?
    let condition: Condition?
}


class DataManager {
    static let shared = DataManager()
    
    var presentationModel: PresentationModel?
    
    private init() {}
    
    func fetchWeather (completion: @escaping (PresentationModel) -> Void) {
        
        
        let urlString = "https://api.weatherapi.com/v1/current.json?key=e5d3d1af10274bc8aef142538250307&q=Novosibirsk&aqi=no"
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, responce, error in
            
            guard let data else { return }
            
            //            print(data.prettyPrinted)
            
            do {
                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                let moreInfo = PresentationModel(
                    location: weather.location.name,
                    temperature: weather.current.tempC,
                    windSpeed: weather.current.windKph,
                    pressure: weather.current.pressureIn,
                    condition: weather.current.condition
                )
                DispatchQueue.main.async {
                    self.presentationModel = moreInfo
                    completion(moreInfo)
                }
            } catch {
                print(error)
                print(error.localizedDescription)
            }
            
        }
        task.resume()
        
    }
}
