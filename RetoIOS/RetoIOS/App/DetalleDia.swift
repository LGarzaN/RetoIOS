//
//  DetalleDia.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 13/11/23.
//

import SwiftUI

struct DetalleDia: View {
    @State var fecha: String
    @State var intensidad: Float
    @State var nota : String
    var body: some View {
        ZStack{
            VStack{
                Text(fecha)
                    .foregroundColor(Color("txt"))
                    .multilineTextAlignment(.leading)
                    .font(.title)
                    .bold()
                    .padding(.top, 30)
                Slider(value:$intensidad)
                    .tint(accentColor(for: $intensidad))
                    .disabled(true)
                    //.padding(.bottom)
                    .padding(.horizontal, 30)
                List{
                    Section{
                        Text("\((intensidad*10).formatted()) / 10")
                    }
                    header: {
                        Text("Intensidad")
                    }
                    Section{
                        Text(nota)
                    }
                    header: {
                        Text("Nota")
                    }
                }
            }
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
        DetalleDia(fecha: "fechA", intensidad: 0.0, nota: "pruebapruebapruebapruebapruebapruebapruebapruebaprueba")
    }
}
