//
//  ContentView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationStack{
            ScrollView(.horizontal){
                LazyHStack(spacing: 0){
                    ForEach(1..<5){ _ in
                        WeatherView(weather: OpenWeatherDataService.instance.weather)
                    }
                 }
             }
            .ignoresSafeArea()
            .navigationBarItems(trailing:
                 NavigationLink {
                    CityMainView()
                } label: {
                    Image(systemName: "list.bullet")
                    .foregroundColor(.white)
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
