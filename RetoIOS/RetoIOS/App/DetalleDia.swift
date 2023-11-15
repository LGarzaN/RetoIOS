//
//  DetalleDia.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 13/11/23.
//

import SwiftUI

struct DetalleDia: View {
    @State var dato : registroDatos
    var body: some View {
        VStack{
            Text("\(dato.fecha.formatted(.dateTime.weekday().day().month().hour()))")
                .foregroundColor(Color("txt"))
            Slider(value:$dato.intensidad)
                .tint(accentColor(for: $dato.intensidad))
                .disabled(true)
                .padding(.bottom)
                .padding(.horizontal, 30)
            HStack{
                Text("Intensidad: ")
                Text("\((dato.intensidad*10).formatted()) / 10")
            }
            .padding()
            Text("Nota")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .foregroundColor(Color("txt"))
                .padding(.bottom, 1)
            
            Text(dato.nota)
                .multilineTextAlignment(.leading)
                .foregroundColor(Color("gry"))
                .padding(.horizontal)
        }
    }
    
    func accentColor(for value: Binding<Float>) -> Color {
            let floatValue = value.wrappedValue
            if floatValue < 0.33 {
                return .green
            } else if floatValue < 0.66 {
                return .yellow
            } else {
                return .red
            }
        }
}

struct DetalleDia_Previews: PreviewProvider {
    static var previews: some View {
        DetalleDia(dato: registroDatos(id: 0, nombre: "nmbre", fecha: Date(), intensidad: 0, nota: "Nota"))
    }
}
