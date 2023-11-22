//
//  DetalleDia.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 13/11/23.
//

import SwiftUI

struct DetalleDia: View {
    @State var dato : RegistroDatos
    var body: some View {
        VStack{
            Text(dato.RegistroFecha)
                .foregroundColor(Color("txt"))
            Slider(value:$dato.RegistroIntensidad)
                .tint(accentColor(for: $dato.RegistroIntensidad))
                .disabled(true)
                .padding(.bottom)
                .padding(.horizontal, 30)
            HStack{
                Text("Intensidad: ")
                Text("\((dato.RegistroIntensidad*10).formatted()) / 10")
            }
            .padding()
            Text("Nota")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .foregroundColor(Color("txt"))
                .padding(.bottom, 1)
            Text(dato.RegistroNota)
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
        DetalleDia(dato: RegistroDatos(idRegistroSintomas: 0, RegistroSintoma: "", RegistroIntensidad: 0, RegistroFecha: "", RegistroNota: "", Usuario_idUsuario: 0, SintomasSeguir_idSintomasSeguir: 0))
    }
}
