//
//  CityMainView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import SwiftUI

struct CityMainView: View {
    @State private var showAlert:Bool = false
    @State private var deleteIndexSet: IndexSet?
    @State private var showSearchCity: Bool = false
    @StateObject private var cds = CityDataService.instance
    var loadWeathers: (() async ->())

    var body: some View {
        NavigationView{
            if cds.cities.isEmpty {
                CityEmptyListView()
                     .modifier(CityListModifier(showSearchCity: showSearchCity, cds: cds))
                     .transition(.scale)
            } else {
                CityListView(cds: cds)
                    .modifier(CityListModifier(showSearchCity: showSearchCity, cds: cds))
                    .refreshable {
                        try? cds.loadCities()
                    }
            }
        }
        .onDisappear{
            Task{
                await loadWeathers()
            }
        }
    }
}

struct CityListModifier: ViewModifier {
    @State var showSearchCity: Bool
    @ObservedObject var cds:CityDataService
    func body(content: Content) -> some View {
        content
            .navigationTitle("Cities")
            .navigationBarItems(trailing:
                    Button("Add City") {
                        showSearchCity.toggle()
                    }
                    .sheet(isPresented: $showSearchCity) {
                        CitySearchView(cds:cds)
                    })
    }
}

// MARK: Small Custom Detent
extension PresentationDetent{
    static let small = Self.height(100)
}

struct MockCityMainViewPreview:View{
    func mock(){}
    var body: some View{
        CityMainView(loadWeathers: mock)
    }
}

struct CityMainView_Previews: PreviewProvider {
    static var previews: some View {
        MockCityMainViewPreview()
    }

}
