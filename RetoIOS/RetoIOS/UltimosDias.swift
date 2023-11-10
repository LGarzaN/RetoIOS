//
//  UltimosDias.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 08/11/23.
//

import SwiftUI

struct UltimosDias: View {
    var dato : DatoSeguir
    @State var accent : Color = .black
    @State var inte = 0.5
    @State var registro = [
        registroDatos(id: 0, nombre: "dato1", fecha: Date(), intensidad: 0.5, nota: ""),
        registroDatos(id: 1, nombre: "dato2", fecha: Date(), intensidad: 0.7, nota: ""),
        registroDatos(id: 2, nombre: "dato3", fecha: Date(), intensidad: 0.4, nota: ""),
        registroDatos(id: 3, nombre: "dato4", fecha: Date(), intensidad: 0.6, nota: "")
    ]
    var body: some View {
        VStack{
            Text(dato.nombreDato)
                .foregroundColor(.black)
                .font(.system(size: 30))
                .frame(width: 333, alignment: .leading)
                .padding()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach($registro){r in
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))

                        VStack{
                            Text("Hi")
                            //Text(r.nombre)
                            Slider(value:r.intensidad)
                                .tint(accentColor(for: r.intensidad))
                                .disabled(true)
                        }
                        .padding()
                    }
                    .padding(.horizontal, 25)
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

struct UltimosDias_Previews: PreviewProvider {
    static var previews: some View {
        UltimosDias(dato: DatoSeguir(id: 0, nombreDato: "Dato", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 0))
    }
}
