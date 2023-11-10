//
//  HPcalendariodatos.swift
//  RetoIOS
//
//  Created by Alumno on 10/11/23.
//

import SwiftUI

struct HPcalendariodatos: View {
    let data: [(date: Date, symptoms: String, registrationTime: String, averageOfDay: String)] = [
            (date: Date(), symptoms: "Dolor de cabeza", registrationTime: "10:30 AM", averageOfDay: "Bueno"),
            (date: Date().addingTimeInterval(86400), symptoms: "Fatiga", registrationTime: "02:45 PM", averageOfDay: "Moderado"),
        ]
        
        var body: some View {
            NavigationView {
                List(data, id: \.date) { item in
                    Section {
                        HStack {
                            Text("Síntoma:")
                            Spacer()
                            Text(item.symptoms)
                        }
                        HStack {
                            Text("Hora de registro:")
                            Spacer()
                            Text(item.registrationTime)
                        }
                        HStack {
                            Text("Promedio del día:")
                            Spacer()
                            Text(item.averageOfDay)
                        }
                    }
                }
                .navigationBarTitle(formattedDate(data[0].date), displayMode: .inline)
            }
        }

        func formattedDate(_ date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = dateFormatter.string(from: date)
            
            let dayFormatter = DateFormatter()
            dayFormatter.locale = Locale(identifier: "es_ES")
            dayFormatter.dateFormat = "EEEE"
            let formattedDay = dayFormatter.string(from: date)
            
            return "\(formattedDay), \(formattedDate)"
        }
}

struct HPcalendariodatos_Previews: PreviewProvider {
    static var previews: some View {
        HPcalendariodatos()
    }
}
