//
//  HPdatos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI
import Charts

struct HPdatos: View {
    var datos = [
        DatoSeguir(id: 0, nombreDato: "Tos", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 1, nombreDato: "Dolor de Cabeza", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 2, nombreDato: "Resequedad", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 3, nombreDato: "Congestion", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 4, nombreDato: "Dolor uña enterrada", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356)
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack{
                            Text("Hola, Usuario")
                                
                                .font(.system(size: 40))
                                .frame(width: 333, alignment: .leading)
                                .padding(.bottom)
                            Text("Seguimiento")
                                .font(.system(size: 28))
                                .frame(width: 333, alignment: .leading)
                            ForEach(datos) { d in
                                
                                NavigationLink {
                                    DatoDetalle(dato: d)
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color(red: 60/255, green: 60/255, blue: 60/255))
                                        
                                        HStack{
                                            VStack{
                                                Text("Dato")
                                                    .fontWeight(.bold)
                                                    .frame(width: 150, alignment: .leading)
                                                    .foregroundColor(.white)
                                                
                                                
                                                Text(d.nombreDato)
                                                    .frame(width: 150, alignment: .leading)
                                                    .foregroundColor(.white)
                                                    .padding(.bottom, 1)
                                                Text("Ultimo Registro")
                                                    .fontWeight(.bold)
                                                    .frame(width: 150, alignment: .leading)
                                                    .foregroundColor(.white)
                                                Text("\(d.ultimoRegistro.formatted())")
                                                    .frame(width: 150, alignment: .leading)
                                                    .foregroundColor(.white)
                                                
                                            }
                                            .padding()
                                            Spacer()
                                            Chart{
                                                LineMark(x: .value("Ciudad", "1"), y: .value("Poblacion", 4))
                                                LineMark(x: .value("Ciudad", "2"), y: .value("Poblacion", 7))
                                                LineMark(x: .value("Ciudad", "3"), y: .value("Poblacion", 2))
                                                LineMark(x: .value("Ciudad", "4"), y: .value("Poblacion", 10))
                                            }
                                            .frame(width: 120, height: 70)
                                            .padding()
                                            
                                        }
                                    }
                                    .frame(width: 333, height: 130)
                                .padding(10)
                                }
                            }
                        }
                    }
                    ButtonBlank(contentTxt: "Agregar Dato", c: .white)
                        .padding()
                }
            }
        }
    }
}

struct HPdatos_Previews: PreviewProvider {
    static var previews: some View {
        HPdatos()
    }
}
