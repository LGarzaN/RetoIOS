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
    @State var registros = [RegistroDatos]()
    @State var alrt : Bool = false
    @AppStorage("usu") var usu = 0
    @State var homeP = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                   .ignoresSafeArea()
                VStack{
                    Text("")
                    Text(dato.SeguirNombre)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20.0)
                        .padding(.top, 20.0)
                        .frame(width: 333, alignment: .leading)
                    Chart{
                        ForEach(registros, id: \.self.idRegistroSintomas) { registro in
                            BarMark(x: .value("Ciudad", String(registro.RegistroFecha.prefix(11))), y: .value("Poblacion", registro.RegistroIntensidad))
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
                                ComoTeSientes(dato: dato)
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
                    .scrollDisabled(true)
                    Button {
                        alrt = true
                    } label: {
                        ButtonBlank(contentTxt: "Finalizar Dato", c: .red)
                    }
                    .alert("¿Está seguro que desea eliminar este dato?", isPresented: $alrt) {
                        Button("Cancelar", role: .cancel) {}
                        Button("Eliminar", role: .destructive) {
                            Task{
                                await finSintoma(link: "http://10.22.129.138:5000", idSintoma: dato.idSintomasSeguir)
                            }
                            homeP = true
                            
                        }
                    }
                    .fullScreenCover(isPresented : $homeP) {
                        Homepage()
                    }
                }
            }
            .onAppear(){
                Task{
                    await getRegistros(link:"http://10.22.129.138:5000", idUsu: usu,idSintoma:dato.idSintomasSeguir)
                }
            }
        }
    }
    
    func getRegistros(link : String, idUsu: Int, idSintoma: Int) async {
        print("1--")
        guard let url = URL(string: "\(link)/registros/\(idUsu)/\(idSintoma)") else {
            print("Wrong URL")
            return
        }
        
        //link+"/registros/"+String(idUsu)+"/"+String(idSintoma)
        print("2")
        do {
            print("in")
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode([RegistroDatos].self, from: data){
                let datos = decodedData
                registros = datos
                print("success")
            }
        }
        catch {
            print("Error: Couldnt bring back data")
        }
        print("4")
    }
    
    func formattedDate(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d MMM yyyy HH:mm:ss z"
        print(dateString)

        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "E, MMM d"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func finSintoma(link : String, idSintoma: Int) async {
        print("1--")
        guard let url = URL(string: "\(link)/finSintoma/\(idSintoma)") else {
            print("Wrong URL")
            return
        }
        
        //link+"/registros/"+String(idUsu)+"/"+String(idSintoma)
        print("2")
        do {
            print("in")
            let(_, _) = try await URLSession.shared.data(from: url)
        }
        catch {
            print("Error: Couldnt bring back data")
        }
        print("4")
    }
}

struct DatoDetalle_Previews: PreviewProvider {
    static var previews: some View {
        DatoDetalle(dato: DatoSeguir(idSintomasSeguir: 0, SeguirNombre: "", SeguirTipo: 0, UltimoRegistro: "", SeguirFechaInicial: "", SeguirFechaFinal: "", Usuario_idUsuario: 0))
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
