//
//  OpenWeatherDataService.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import Foundation

@MainActor
class OpenWeatherDataService:ObservableObject {
    
    static var instance = OpenWeatherDataService()
    private init(){ }
    
    @Published var weather:OpenWeather?
    @Published var openWeatherError:OpenWeatherError?
    @Published var weathers:[OpenWeather?] = []

    let APIKey = "6e7647427db47fa9e311f071293a8cb6"  // <--- TYPE YOUR KEY HERE

    func buildURL(cityName:String)->URL?{
        var uc = URLComponents()
        uc.scheme = "http"
        uc.host = "api.openweathermap.org"
        uc.path = "/data/2.5/weather"
        uc.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "APPID", value: APIKey),
            URLQueryItem(name: "units", value: "metric")
        ]
        return uc.url
    }
    
    func loadWeather(cityName:String) async -> OpenWeather?{
        guard let url = buildURL(cityName: cityName) else {
            return nil
        }
        do{
            print("\(url.absoluteString)")
            let (weatherData, _) = try await URLSession.shared.data(from: url)
            let str = String(decoding: weatherData, as: UTF8.self)
            if str.contains("{\u{22}cod\u{22}:") {
                let decode = JSONDecoder()
                let result = try decode.decode(OpenWeatherError.self, from: weatherData)
                openWeatherError = result
                return nil
            } else {
                print("\(str)")
                let decode = JSONDecoder()
                let result = try decode.decode(OpenWeather.self, from: weatherData)
                return result
            }
        } catch {
            print("\(error)")
        }
        return nil
    }
    
    func loadWeathers(cityNames:[String]) async throws ->[OpenWeather?] {
        return try await withThrowingTaskGroup(of: OpenWeather?.self, body: { group -> [OpenWeather?] in
            for city in cityNames {
                group.addTask {
                    await self.loadWeather(cityName: city) ?? nil
                }
            }
            var result = [OpenWeather?]()
            for try await value in group{
                result.append(value)
            }
            
            await MainActor.run(body: {
                self.weathers = result
            })
            
            return result
        })
    }
    
    func convertToCelsius(fahrenheit: Int) -> Int {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}
