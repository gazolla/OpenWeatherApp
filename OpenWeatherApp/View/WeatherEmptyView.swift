//
//  WeatherEmptyView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import SwiftUI

struct WeatherEmptyView: View {
    var body: some View {
             VStack{
                 Spacer()
                Image("MapPin")
                    
                Text ("There are no Weather to show!")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding()
                Text("You should click the \(Image(systemName: "list.bullet")) button and add some cities!")
                     .multilineTextAlignment(.center)
                Spacer()
            }
            .padding(40)
    }
}

struct WeatherEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherEmptyView()
    }
}
