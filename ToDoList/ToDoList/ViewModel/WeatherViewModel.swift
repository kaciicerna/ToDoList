//
//  WeatherViewModel.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    
    func fetchWeather() {
        guard let url = URL(string: "https://www.weatherapi.com/docs/conditions.json") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(Welcome.self, from: data)
                
                // Filter the weather data for the Czech language
                if let czechWeather = weatherData.first(where: { $0.languages.contains(where: { $0.langName == .czech }) }) {
                    self.weather = Weather(code: czechWeather.code, day: czechWeather.day, night: czechWeather.night, icon: String(czechWeather.icon))
                }
            } catch {
                print("Failed to decode weather data:", error)
            }
        }.resume()
    }
}

struct Weather: Identifiable {
    let id = UUID()
    let code: Int
    let day: String
    let night: String
    let icon: String?
}
