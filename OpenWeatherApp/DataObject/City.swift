//
//  City.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import Foundation
import MapKit

struct City: Identifiable, Equatable, Codable{
    var id = UUID()
    var name:String?
    var country:String?
    var flagIconURL: String?
    var placemark:CLPlacemark?
    
    private enum CodingKeys: String, CodingKey {
        case name, country, flagIconURL//, placemark
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey:.name)
        country = try container.decode(String.self, forKey: .country)
        flagIconURL = try container.decode(String.self, forKey: .flagIconURL)
        //placemark = try container.decode(CLPlacemark.self, forKey: .placemark)
    }

    init(placemark:CLPlacemark){
        self.name = placemark.name
        self.country = placemark.country
        self.flagIconURL = placemark.isoCountryCode
        self.placemark = placemark
    }
    
    init(name: String? = nil, country: String? = nil, flagIconURL: String? = nil, placemark: CLPlacemark? = nil) {
        self.name = name
        self.country = country
        self.flagIconURL = flagIconURL
        self.placemark = placemark
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.id == rhs.id
    }
}
