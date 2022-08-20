//
//  OpenWeather.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import Foundation
import SwiftUI

struct OpenWeather: Codable, Identifiable{
    var coord: Coord?
    var weather:[Weather]?
    var base: String?
    var main:Main?
    var visibility: Int?
    var wind:Wind?
    var clouds:Clouds?
    var dt:Double?
    var sys:Sys?
    var timezone:Int?
    var id = UUID()
    var name:String?
    var cod:Int?
    var appearence:WeatherAppearence?{
        Appearences().appearences[weather?[0].icon ?? ""]
    }
    var date:Date{
        Date(timeIntervalSince1970: dt!)
    }
    var weekday:String?{
      //  guard let date = date else { return nil }
        let weekdayIndex = Calendar.current.component(.weekday, from: date) - 1
        let weekday = DateFormatter().weekdaySymbols[weekdayIndex]
        return "\(weekday)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case coord, weather, base, main, visibility, wind, clouds, dt, sys, timezone, name, cod
        
    }
}

extension OpenWeather:  Hashable {
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    public static func == (lhs: OpenWeather, rhs: OpenWeather) -> Bool {
        return lhs.id == rhs.id
    }
}

extension OpenWeather: CustomStringConvertible {
    var description: String {
        return "\(name!) temp:\(main!.temp!) \(weather![0].main!) \(appearence!.iconName)  \(date) \(weekday!)"
    }
}

struct Coord: Codable {
    var lat:Double?
    var lon:Double?
}

struct Weather: Identifiable, Codable {
    var id:Int?
    var main:String?
    var description:String?
    var icon:String?
}

struct Main:Codable {
    var temp:Double?
    var feels_like:Double?
    var temp_min:Double?
    var temp_max:Double?
    var pressure:Int?
    var humidity:Int?
}

struct Wind:Codable{
    var speed:Double?
    var deg:Int?
}

struct Clouds:Codable{
    var all:Int
}

struct Sys:Codable{
    var type:Int?
    var id:Int?
    var country:String?
    var sunrise:Int?
    var sunset:Int?
}

struct WeatherAppearence {
    var iconName:String
    var background:Gradient
}

struct Appearences{
    let appearences:[String:WeatherAppearence] = [
        "01d": WeatherAppearence(iconName: "sun.max.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))])),
        "02d": WeatherAppearence(iconName: "cloud.sun.rain.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))])),
        "03d": WeatherAppearence(iconName: "cloud.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))])),
        "04d": WeatherAppearence(iconName: "smoke.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))])),
        "09d": WeatherAppearence(iconName: "cloud.rain.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))])),
        "10d": WeatherAppearence(iconName: "cloud.sun.rain.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))])),
        "11d": WeatherAppearence(iconName: "cloud.bolt.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))])),
        "13d": WeatherAppearence(iconName: "snowflake", background: Gradient(colors:[Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))])),
        "50d": WeatherAppearence(iconName: "sun.max.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1))])),
        "01n": WeatherAppearence(iconName: "moon.stars.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "02n": WeatherAppearence(iconName: "cloud.moon.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "03n": WeatherAppearence(iconName: "cloud.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "04n": WeatherAppearence(iconName: "smoke.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "09n": WeatherAppearence(iconName: "cloud.rain.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "10n": WeatherAppearence(iconName: "cloud.moon.rain.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "11n": WeatherAppearence(iconName: "cloud.bolt.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "13n": WeatherAppearence(iconName: "snowflake", background: Gradient(colors:[Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))])),
        "50n": WeatherAppearence(iconName: "sun.max.fill", background: Gradient(colors:[Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))]))
    ]
}
