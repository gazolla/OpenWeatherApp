//
//  OpenWeatherDataService.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import Foundation


class OpenWeatherDataService:ObservableObject {
    
    static var instance = OpenWeatherDataService()
    private init(){
        print("loading...")
        loadWeather()
    }
    
    @Published var weather:OpenWeather?
    
    let response = """
    {"coord":{"lon":-0.1257,"lat":51.5085},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01n"}],"base":"stations","main":{"temp":26,"feels_like":286.44,"temp_min":283.35,"temp_max":288.71,"pressure":1017,"humidity":80},"visibility":10000,"wind":{"speed":3.6,"deg":230},"clouds":{"all":0},"dt":1660966194,"sys":{"type":2,"id":2075535,"country":"GB","sunrise":1660971231,"sunset":1661022862},"timezone":3600,"id":2643743,"name":"London","cod":200}
    """
    
    func loadWeather(){
        do {
            print("\(response)")
            let data = Data(response.utf8)
            let decoder = JSONDecoder()
            let result = try decoder.decode(OpenWeather.self, from: data)
            print("\(result)")
            weather = result
        } catch{
            print("\(error)")
        }
    }
}
