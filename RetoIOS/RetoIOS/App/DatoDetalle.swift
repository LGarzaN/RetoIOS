//
//  DatoDetalle.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 03/11/23.
//

import SwiftUI
import Charts

struct DatoDetalle: View {
    var dato : DatoSeguir
    @State var alrt : Bool = false
    var listaRegistro  = [
        registroDatos(id: 0, nombre: "Tos", fecha: Date(), intensidad: 4, nota: ""),
        registroDatos(id: 1, nombre: "Tos", fecha: Date(), intensidad: 2, nota: ""),
        registroDatos(id: 2, nombre: "Tos", fecha: Date(), intensidad: 7, nota: ""),
        registroDatos(id: 3, nombre: "Tos", fecha: Date(), intensidad: 5, nota: ""),
        registroDatos(id: 4, nombre: "Tos", fecha: Date(), intensidad: 9, nota: ""),
        registroDatos(id: 5, nombre: "Tos", fecha: Date(), intensidad: 3, nota: ""),
        registroDatos(id: 6, nombre: "Tos", fecha: Date(), intensidad: 1, nota: "")
    ]
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                   .ignoresSafeArea()
                VStack{
                    Text(dato.nombreDato)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20.0)
                        .padding(.top, 20.0)
                        .frame(width: 333, alignment: .leading)
                    Chart{
                        ForEach(listaRegistro) { registro in
                            BarMark(x: .value("Ciudad", registro.id), y: .value("Poblacion", registro.intensidad))
                        }
                    }
                    .frame(width: 330, height: 200)
                    Text("Seguimiento")
                        .foregroundColor(.gray)
                        .frame(width: 333, alignment: .leading)
                        .padding()
                        .font(.system(size: 25))
                    Form{
                        Section{
                            NavigationLink {
                                ComoTeSientes()
                            } label: {
                                Text("¿Cómo te sientes?")
                            }
                        }
                        Section{
                            NavigationLink {
                                UltimosDias(dato: dato)
                            } label: {
                                Text("Últimos Días")
                            }                        }
                    }
                    Button {
                        alrt = true
                    } label: {
                        ButtonBlank(contentTxt: "Finalizar Dato", c: .red)
                    }
                    .alert("¿Está seguro que desea eliminar este dato?", isPresented: $alrt) {
                        Button("Cancelar", role: .cancel) {}
                        Button("Eliminar", role: .destructive) {}
                    }
                }
            }
        }
    }
}

struct DatoDetalle_Previews: PreviewProvider {
    static var previews: some View {
        DatoDetalle(dato: DatoSeguir(id: 0, nombreDato: "Dato", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 0))
    }
}

/*
 
 import SwiftUI
 import Charts

 struct DatoDetalle: View {
     var dato : DatoSeguir
     var listaRegistro  = [
         registroDatos(id: 0, nombre: "Tos", fecha: Date(), intensidad: 4, nota: ""),
         registroDatos(id: 1, nombre: "Tos", fecha: Date(), intensidad: 2, nota: ""),
         registroDatos(id: 2, nombre: "Tos", fecha: Date(), intensidad: 7, nota: ""),
         registroDatos(id: 3, nombre: "Tos", fecha: Date(), intensidad: 5, nota: ""),
         registroDatos(id: 4, nombre: "Tos", fecha: Date(), intensidad: 9, nota: ""),
         registroDatos(id: 5, nombre: "Tos", fecha: Date(), intensidad: 3, nota: ""),
         registroDatos(id: 6, nombre: "Tos", fecha: Date(), intensidad: 1, nota: "")
     ]
     var body: some View {
         NavigationStack{
             VStack{
                 Text(dato.nombreDato)
                     .foregroundColor(.black)
                     .font(.system(size: 30))
                     .frame(width: 333, alignment: .leading)
                     .padding()
                 Chart{
                     ForEach(listaRegistro) { registro in
                         BarMark(x: .value("Ciudad", registro.id), y: .value("Poblacion", registro.intensidad))
                     }
                 }
                 .frame(width: 333, height: 200)
                 Text("Seguimiento")
                     .foregroundColor(.gray)
                     .frame(width: 333, alignment: .leading)
                     .padding()
                     .font(.system(size: 25))
             }

             Form{
                 Section{
                     NavigationLink {
                         ComoTeSientes()
                     } label: {
                         Text("¿Cómo te sientes?")
                     }
                 }
                 Section{
                     NavigationLink {
                         
                     } label: {
                         Text("Últimos Días")
                     }                        }
             }
             ButtonBlank(contentTxt: "Finalizar dato", c: .black)
         }
     }
 }

 struct DatoDetalle_Previews: PreviewProvider {
     static var previews: some View {
         DatoDetalle(dato: DatoSeguir(id: 0, nombreDato: "Dato", fechaIni: Date(), fechaFin: Date(), ultimoRegistro: Date(), tipo: 0, idPaciente: 0))
     }
 }

 */
