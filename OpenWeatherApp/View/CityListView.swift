//
//  CityListView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 20/08/22.
//

import SwiftUI

struct CityListView: View {
    @State private var showAlert:Bool = false
    @State private var deleteIndexSet: IndexSet?
    @StateObject var cds:CityDataService

    var body: some View {
        List{
            ForEach(cds.cities){ city in
                NavigationLink(destination: CityInfoView(city:city)) {
                    CityCellView(city: city)
                }
             }
            .onDelete(perform: { indexSet in
                self.showAlert = true
                self.deleteIndexSet = indexSet
            })
            .alert(isPresented: $showAlert) {
                let indexSet = self.deleteIndexSet
                return Alert(
                    title: Text("Are you sure?"),
                    primaryButton: .cancel(),
                    secondaryButton: .destructive(Text("Delete"),
                                    action: {
                                        withAnimation {
                                            deleteCity(at: indexSet!)
                                        }
                }))
            }
        }
    }
    
    private func deleteCity(at indexSet: IndexSet){
        withAnimation {
            cds.deleteCity(at: indexSet)
            try! cds.saveCities()
        }
    }
}

struct CityListViewWrapper: View{
    @StateObject private var cds = CityDataService.instance
    var body: some View {
        NavigationView{
            CityListView(cds:cds)
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListViewWrapper()
    }
}
