//
//  HPdatos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI
import Charts

struct HPdatos: View {
    @State var alrt = false
    var datos = [
        DatoSeguir(id: 0, nombreDato: "Tos", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 1, nombreDato: "Dolor de Cabeza", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 2, nombreDato: "Resequedad", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 3, nombreDato: "Congestion", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356),
        DatoSeguir(id: 4, nombreDato: "Dolor uña enterrada", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 356)
    ]
    let options = ["Tos", "Dolor de Cabeza", "Otro"]
    @State private var selectedOption = 0
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                    .ignoresSafeArea()
                VStack{
                    Form{
                        ForEach(datos) { d in
                            Section{
                                NavigationLink {
                                    DatoDetalle(dato: d)
                                } label:{
                                    HStack{
                                        VStack(alignment: .leading){
                                            Text("Dato")
                                            Text(d.nombreDato)
                                                .foregroundColor(.secondary)
                                                .padding(.bottom, 5)
                                            Text("Ultimo Registro")
                                            Text("\(d.ultimoRegistro.formatted())")
                                                .foregroundColor(.secondary)
                                        }
                                        .padding(.trailing, 10)
                                        Chart{
                                            LineMark(x: .value("Ciudad", "1"), y: .value("Poblacion", 4))
                                            LineMark(x: .value("Ciudad", "2"), y: .value("Poblacion", 7))
                                            LineMark(x: .value("Ciudad", "3"), y: .value("Poblacion", 2))
                                            LineMark(x: .value("Ciudad", "4"), y: .value("Poblacion", 10))
                                        }
                                        .frame(width: 120, height: 70)
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                        }
                    }
                    .navigationTitle("Seguimiento")
                    Button {
                        alrt = true
                    } label: {
                        ButtonBlank(contentTxt: "Agregar Dato", c: .blu)
                    }
                    .padding()
                    .sheet(isPresented: $alrt) {
                        Picker("picker", selection: $selectedOption) {
                            ForEach(options, id: \.self){ opt in
                                Text(opt)
                            }
                        }
                        Text("Hola")
                        .presentationDetents([.medium, .large])
                    }
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
/*
 
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
                 Color("basic")
                     .ignoresSafeArea()
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
                                             .foregroundColor(Color("butts"))
                                         
                                         HStack{
                                             VStack{
                                                 Text("Dato")
                                                     .fontWeight(.bold)
                                                     .frame(width: 150, alignment: .leading)
                                                     .foregroundColor(Color("txt"))
                                                 Text(d.nombreDato)
                                                     .frame(width: 150, alignment: .leading)
                                                     .padding(.bottom, 1)
                                                     .foregroundColor(Color("txt"))
                                                 Text("Ultimo Registro")
                                                     .fontWeight(.bold)
                                                     .frame(width: 150, alignment: .leading)
                                                     .foregroundColor(Color("txt"))
                                                 Text("\(d.ultimoRegistro.formatted())")
                                                     .frame(width: 150, alignment: .leading)
                                                     .foregroundColor(Color("txt"))
                                                 
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
                     Button {
                         //
                     } label: {
                         ButtonBlank(contentTxt: "Agregar Dato", c: .blu)
                     }
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
*/
