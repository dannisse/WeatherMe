//
//  ContentView.swift
//  WeatherMe
// Note: This code was created by Bahalek on 2021-12-24, and was used for instructional purposes only.

import SwiftUI

struct ContentView: View {
    @StateObject private var weatherAPIClient = WeatherAPIClient()
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Spacer()
            if let currentWeather = weatherAPIClient.currentWeather  {
                HStack(alignment: .center, spacing: 16) {
                    currentWeather.weatherCode.image
                        .font(.largeTitle)
                    Text("\(currentWeather.temperature)º")
                        .font(.largeTitle)
                }
                Text(currentWeather.weatherCode.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
            } else {
                Text("No weather info available.\nTap on refresh to try again.\nMake sure you have enabled location permissions for the app :).")
                    .font(.body)
                    .multilineTextAlignment(.center)
                Button("Refresh", action: {
                    Task {
                        await weatherAPIClient.fetchWeather()
                    }
                })
            }
            Spacer()
        }
        .onAppear {
            Task {
                await weatherAPIClient.fetchWeather()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
