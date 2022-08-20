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
                if owds.openWeatherError == nil {
                    if owds.weathers.isEmpty {
                        if isLoading {
                            showLoading
                        } else {
                            WeatherEmptyView()
                                .transition(.scale)
                        }
                    } else {
                        showWeathers
                    }
                } else {
                    showError
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
        .transition(.opacity)
    }
    
    var showLoading: some View{
        VStack(alignment: .center){
            Text("Weather").font(.largeTitle).fontWeight(.bold)
            Text("is loading...").font(.headline).fontWeight(.thin)
        }
        .transition(.scale)
    }
    
    var showProgress: some View{
        ProgressView()
    }
    
    var showError: some View {
        VStack(spacing: 150){
            Spacer()
            List{
                Section(header: Text("Error")) {
                    VStack(alignment: .leading){
                        Text("code: \(owds.openWeatherError?.cod ?? 0)")
                        Text(owds.openWeatherError?.message ?? "")
                            .font(.subheadline.weight(.semibold))
                    }
                }
            }
        }
        .navigationTitle(Text("OpenWeather App"))
    }
    
    func loadWeathers() async {
        do {
            withAnimation { isLoading = true }
            let _ = try await owds.loadWeathers(cityNames: cds.getCityNames())
            withAnimation { isLoading = false }
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
