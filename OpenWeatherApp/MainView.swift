//
//  ContentView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        WeatherView(weather: OpenWeatherDataService.instance.weather)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
