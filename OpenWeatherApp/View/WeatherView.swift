//
//  WeatherView.swift
//  OpenWeatherApp
//
//  Created by sebastiao Gazolla Costa Junior on 19/08/22.
//

import SwiftUI

struct WeatherView: View {
    @State var weather:OpenWeather?
    var body: some View {
        
        VStack(alignment: .center){
            if let weather = weather{
                Text(weather.name!)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                HStack{
                    Text(weather.weekday!)
                        .foregroundColor(.white)
                    Text("-")
                        .foregroundColor(.white)
                    Text(weather.date, style: .date)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
                Text("\(weather.main!.temp!.roundz())º")
                    .font(.system(size: 120, weight: .bold))
                    .foregroundColor(.white)
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                
                    Image(systemName: weather.appearence!.iconName)
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    
                    Text(weather.weather![0].description!)
                        .foregroundColor(.white)
                        .font(.title)
               
                
                
                VStack{
                 
                        Text("Details")
                            .foregroundColor(.white)
                            .font(.title2)
                            .frame(maxWidth:.infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
                        Divider()
                            .overlay(.white)
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 20))
                    
                    HStack{
                        detail(imgName: "thermometer", text: "Feels Like", value:    "\(weather.main!.feels_like!)")
                        detail(imgName: "wind", text: "Wind", value:    "\(weather.wind!.speed!)")
                        detail(imgName: "humidity.fill", text: "humidity", value:    "\(weather.main!.humidity!)")
                    }
                    HStack{
                        detail(imgName: "eye", text: "Visibility", value:    "\(weather.visibility!)")
                        detail(imgName: "speedometer", text: "Pressure", value:    "\(weather.main!.pressure!)")
                        detail(imgName: "cloud", text: "clouds", value:    "\(weather.clouds!.all)")
                    }
                }
               // .frame(maxWidth: .infinity)
                .padding(25)
                Spacer()
                    

                
            } else {
                Text("loading....")
            }
        }
        .padding(EdgeInsets(top: 80, leading: 0, bottom: 0, trailing: 0))
        .background{
            Rectangle()
            LinearGradient(
                gradient: weather!.appearence!.background,
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
        }
    }
    
    fileprivate func detail(imgName:String, text:String, value:String) -> some View {
        return VStack{
            Image(systemName: imgName)
                .font(.title2)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            Text(text)
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
            Text(value)
                .fontWeight(.light)
        }
        .frame(width: 100, height: 100)
        .foregroundColor(.white)
        .background{
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white)
        }
        .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
    }
    

}

struct weatherViewWrapper:View{
    var body: some View{
        WeatherView(weather:OpenWeatherDataService.instance.weather)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        weatherViewWrapper()
    }
}
