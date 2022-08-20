//
//  CityEmptyListView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import SwiftUI

struct CityEmptyListView: View {
    @State private var animate:Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 10) {
                
                Image("City")
                    .padding()
                Text ("There are no Cities!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("You should click the add button and add a bunch of cities to your Weather App!")
                
                    .multilineTextAlignment(.center)
                    .padding(40)
            }
        }
        .frame(maxWidth:.infinity, maxHeight:.infinity)
        .onAppear{
            animate.toggle()
        }
    }
}

struct CityEmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        CityEmptyListView()
    }
}
