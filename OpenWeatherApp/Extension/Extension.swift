//
//  Extension.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import Foundation

extension Double{
    func round() -> String{
        String(format:"%.1f", self)
    }
    func roundz() -> String{
        String(format:"%.0f", self)
    }
}
