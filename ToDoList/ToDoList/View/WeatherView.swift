//
//  WeatherView.swift
//  ToDoList
//
//  Created by Kateřina Černá on 28.06.2023.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        HStack(spacing: 10) {
            if let weather = viewModel.weather {
                Text("Weather: \(weather.day)")
                    .font(.title3)
                
                if let iconName = weather.icon {
                    Image(iconName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                }
            } else {
                Text("Loading weather data...")
                    .font(.title)
            }
        }
        .onAppear {
            viewModel.fetchWeather()
        }
    }
}

