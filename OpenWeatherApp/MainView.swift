//
//  ContentView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import SwiftUI

struct MainView: View {
    @StateObject var owds = OpenWeatherDataService.instance
    @ObservedObject var cds = CityDataService.instance
    @State var isLoading = true
    var body: some View {
        NavigationStack{
            ZStack{
                if owds.weathers.isEmpty {
                    if isLoading {
                        VStack(alignment: .center){
                            Text("Weather").font(.largeTitle).fontWeight(.bold)
                            Text("is loading...").font(.headline).fontWeight(.thin)
                        }
                        .transition(.scale)
                    } else {
                        WeatherEmptyView()
                            .transition(.scale)
                    }
                } else {
                    showWeathers
                        .transition(.opacity)
                }
            }
            .onAppear() {
                Task{
                    await loadWeathers()
                }
            }
            .ignoresSafeArea()
            .navigationBarItems(leading:isLoading ? showProgress : nil , trailing:
                                    NavigationLink {
                CityMainView(loadWeathers: loadWeathers)
            } label: {
                Image(systemName: "list.bullet")
                    .foregroundColor( owds.weathers.isEmpty ? .black : .white)
            })
            
        }
    }
    
    var showWeathers: some View{
        ScrollView(.horizontal){
            LazyHStack(spacing: 0){
                ForEach(owds.weathers, id:\.self){ weather in
                    WeatherView(weather: weather)
                }
            }
        }
    }
    
    var showProgress: some View{
        ProgressView()
    }
    
    func loadWeathers() async {
        do {
            isLoading = true
            let _ = try await owds.loadWeathers(cityNames: cds.getCityNames())
            withAnimation(.easeInOut) {
                isLoading = false
            }
        } catch {
            print("\(error)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
