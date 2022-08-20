//
//  WeatherView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import SwiftUI

struct WeatherView: View {
    @State var weather:OpenWeather?
    var body: some View {
        
        VStack(){
            if let weather = weather{
                Text(weather.name!)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                HStack{
                    Text(weather.weekday!)
                        .foregroundColor(.white)
                    Text("-")
                        .foregroundColor(.white)
                    Text(weather.date, style: .date)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Text("\(weather.main!.temp!.round())º")
                    .font(.system(size: 150, weight: .bold))
                    .foregroundColor(.white)
                HStack{
                    Image(systemName: weather.appearence!.iconName)
                        .font(.title)
                        .foregroundColor(.yellow)
                    
                    Text(weather.weather![0].description!)
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    
                    Text("Feels like \(weather.main!.feels_like!.round())º")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20))
                
                HStack{
                    Text("Wind: \(weather.wind!.speed!.round()) km/h")
                        .foregroundColor(.white)
                        .font(.headline)
                    Spacer()
                    Text("precipitation: \(weather.main!.humidity!) %")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Spacer()
                
            } else {
                Text("loading....")
            }
        }
        .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
        .background{
            Rectangle()
            LinearGradient(
                gradient: weather!.appearence!.background,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
    }
    
}

struct weatherViewWrapper:View{
    var body: some View{
        WeatherView(weather:OpenWeatherDataService.instance.weather)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        weatherViewWrapper()
    }
}
