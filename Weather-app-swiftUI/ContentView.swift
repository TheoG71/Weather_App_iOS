//
//  ContentView.swift
//  Weather-app-swiftUI
//
//  Created by Lilian on 08/03/2021.
//

import SwiftUI

struct ContentView: View {
    private let weatherViewModel = WeatherViewModel()
    @State private var weather: WeatherModel?
    @State var showAlert: Bool = false
    
    
    
    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: colors),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(weather?.city.fullName ?? "")
                    .font(.system(size: 50, weight:.medium, design:.default))
                    .foregroundColor(Color.white)
                    .padding()
                Image(systemName: weather?.firstHour?.imageName ?? "")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text(weather?.firstHour?.temperature.formattedCelsius ?? "")
                    .font(.system(size: 50, weight:.medium, design:.default))
                    .foregroundColor(Color.white)
                    .padding(Edge.Set.bottom, 40)
            
                HStack(spacing: 20) {
                    HourlyWeather(hourlyWeather: weather?.firstHour)
                    HourlyWeather(hourlyWeather: weather?.secondHour)
                    HourlyWeather(hourlyWeather: weather?.thirdHour)
                    HourlyWeather(hourlyWeather: weather?.fourthHour)
                    HourlyWeather(hourlyWeather: weather?.fifthHour)
                }
                
                Spacer()
                
                
                Button(action: {
                    
                    alertView()
                    
                    }, label: {
                        Text("Choisir une autre ville")
                            .frame(width: 300, height: 50)
                            .background(Color.white)
                            .font(.system(size: 20, weight: .bold, design: .default))
                            .cornerRadius(4)
                    })
            }
        } .onAppear(perform: loadData)
    }
    
    var colors: [Color] {
        if weather?.firstHour?.temperature.isCold ?? true {
            return [Color.blue , Color("lightBlue")]
        } else {
            return [Color.red , Color("lightRed")]
        }
    }
    
    private func loadData() {
        weatherViewModel.showHandler = { weather in
            DispatchQueue.main.async {
                self.weather = weather
            }
        }
        weatherViewModel.getWeather(ville: "Paris")
    }
    
    
    func alertView() {
        let alert = UIAlertController(title: "Choisir une nouvelle ville", message: "", preferredStyle: .alert)
        var ville: String = ""
        
        alert.addTextField { (city) in
            
            city.placeholder = "Ville"
        }
        
        let annuler = UIAlertAction(title: "Annuler", style: .destructive){ (_) in
            
        }
        
        let ok = UIAlertAction(title: "Ok", style: .default){ (_) in
            if alert.textFields![0].text?.isEmpty == false {
                
                ville = alert.textFields![0].text!
                weatherViewModel.getWeather(ville: ville)
            }
            
            
        }
        
        alert.addAction(annuler)
        alert.addAction(ok)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true, completion: {
            
        })
        
        
    }
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HourlyWeather: View {
    var hourlyWeather: Weather?
    
    var body: some View {
        VStack {
            Text(hourlyWeather?.formattedDate ?? "")
                .font(.system(size: 20, weight:.medium, design:.default))
                .foregroundColor(Color.white)
            Image(systemName: hourlyWeather?.imageName ?? "")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text(hourlyWeather?.temperature.formattedCelsius ?? "")
                .font(.system(size: 20, weight:.medium, design:.default))
                .foregroundColor(Color.white)
        }
    }
}




