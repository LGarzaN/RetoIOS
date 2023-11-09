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
    @State var intensidad:Float = 0.0
    var registro = [
        registroDatos(id: 0, nombre: "dato", fecha: Date(), intensidad: 0.5, nota: ""),
        registroDatos(id: 0, nombre: "dato", fecha: Date(), intensidad: 0.7, nota: ""),
    registroDatos(id: 0, nombre: "dato", fecha: Date(), intensidad: 2, nota: ""),
    registroDatos(id: 0, nombre: "dato", fecha: Date(), intensidad: 9, nota: "")
    ]
    var body: some View {
        VStack{
            Text(dato.nombreDato)
                .foregroundColor(.black)
                .font(.system(size: 30))
                .frame(width: 333, alignment: .leading)
                .padding()
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(registro){ r in
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))

                        VStack{
                            Text("\(r.fecha.formatted(.dateTime.weekday(.wide).day()))")
                            Slider(value: $intensidad)
                                .padding(.horizontal, 30)
                                .padding(.bottom, 15)
                                .tint(accent)
                                .disabled(true)
                        }
                        .onChange(of: r.intensidad, perform: { newValue in
                            f(val: r.intensidad)
                        })
                        .onAppear{
                            f(val: r.intensidad)
                        }
                    }


                    .padding(.horizontal, 25)
                }
            }
        }
    }
    func accentColor(for value: Double) -> Color {
        if value < 0.33 {
            return .green
        } else if value < 0.66 {
            return .yellow
        } else {
            return .red
        }
    }
    func f (val : Float) -> Void{
        intensidad = val
    }
}

struct UltimosDias_Previews: PreviewProvider {
    static var previews: some View {
        UltimosDias(dato: DatoSeguir(id: 0, nombreDato: "Dato", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 0))
    }
}
