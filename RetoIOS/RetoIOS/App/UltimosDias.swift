//
//  UltimosDias.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 08/11/23.
//  Juan logro que jale :)
//

import SwiftUI

struct UltimosDias: View {
    var dato : DatoSeguir
    //@State var accent : Color = .black
    @State var inte = 0.5
    @State var registro = [
        registroDatos(id: 0, nombre: "dato1", fecha: Date(), intensidad: 0.5, nota: "El dia de ayer me estuvo doliendo la panza todo el dia y tenia ganas de vomitar"),
        registroDatos(id: 1, nombre: "dato2", fecha: Date(), intensidad: 0.7, nota: ""),
        registroDatos(id: 2, nombre: "dato3", fecha: Date(), intensidad: 0.2, nota: ""),
        registroDatos(id: 3, nombre: "dato4", fecha: Date(), intensidad: 0.6, nota: "")
    ]
    var body: some View {
        NavigationStack {
            VStack{
                Text(dato.nombreDato)
                    .font(.system(size: 30))
                    .frame(width: 333, alignment: .leading)
                    .padding()
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach($registro){r in
                        NavigationLink{
                            
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("butts"))
                                VStack{
                                    Text("\(r.fecha.wrappedValue.formatted(.dateTime.weekday().day().month().hour()))")
                                        .foregroundColor(Color("txt"))
                                    Slider(value:r.intensidad)
                                        .tint(accentColor(for: r.intensidad))
                                        .disabled(true)
                                    Text("Nota")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding()
                                        .foregroundColor(Color("txt"))
                                    
                                    Text(r.nota.wrappedValue)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(Color("gry"))
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                }
                                .padding()
                            }
                            .padding(.horizontal, 20)
                            .padding(5)
                        }
                    }
                }
            }
            .background(Color("basic"))
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
