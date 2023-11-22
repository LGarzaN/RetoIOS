//
//  HPdatos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI
import Charts

struct HPdatos: View {
    let dbLink = "http://10.22.129.138:5000"
    @State var alrt = false
    @State var tip = 0
    @State var datosList = [DatoSeguir]()
    let options = ["Tos", "Dolor de Cabeza", "Otro"]
    let tipoOpciones = ["Cualitativo", "Cuantitativo"]
    @State var tipo = ""
    @State var datoExtra = ""
    @State private var selectedOption = ""
    @AppStorage("usu") var usu = 0
    @AppStorage ("API_KEY") var key = "Juan"
    var body: some View {
        GeometryReader{geo in
            NavigationStack{
                ZStack{
                    Color("basic")
                        .ignoresSafeArea()
                    Image("Logo")
                        .frame(width: geo.size.width, height: geo.size.height/2, alignment: .leading)
                        .opacity(0.12)
                    VStack{
                        Form{
                            ForEach(datosList, id: \.self.idSintomasSeguir) { d in
                                Section{
                                    NavigationLink {
                                        DatoDetalle(dato: d)
                                    } label:{
                                        HStack{
                                            VStack(alignment: .leading){
                                                //Text("Dato")
                                                Text(d.SeguirNombre)
                                                    .foregroundColor(.secondary)
                                                    .padding(.bottom, 5)
                                                Text("Ultimo Registro")
                                                Text(d.UltimoRegistro)
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
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                         Button {
                             alrt = true
                         } label: {
                             ButtonBlank(contentTxt: "Agregar Dato", c: .blu)
                         }
                        .padding()
                        .sheet(isPresented: $alrt) {
                            VStack{
                                Picker("picker", selection: $selectedOption) {
                                    ForEach(options, id: \.self){ opt in
                                        Text(opt)
                                    }
                                }
                                if (selectedOption == "Otro"){
                                    TextField("Dato a seguir", text: $datoExtra)
                                        .textFieldStyle(.roundedBorder)
                                        .padding()
                                    Picker("picker", selection: $tipo) {
                                        ForEach(tipoOpciones, id: \.self){ opt in
                                            Text(opt)
                                        }
                                    }
                                }
                                Button{
                                    if (selectedOption == "Otro"){
                                        selectedOption = datoExtra
                                    }
                                    if (tipo == "Cualitativo"){
                                        tip = 0
                                    } else {
                                        tip = 1
                                    }
                                    let datoS = DatoSeguir(idSintomasSeguir: 0, SeguirNombre: selectedOption, SeguirTipo: tip, UltimoRegistro: "", SeguirFechaInicial: "", SeguirFechaFinal: "", Usuario_idUsuario: usu)
                                    datoS.formatDate(Date())
                                    
                                    Task{
                                        await postData(link: dbLink, postData: datoS)
                                        await getData(link: dbLink, numId: usu)
                                    }
                                    alrt = false
                                    
                                } label: {
                                    Text("Agregar")
                                }
                            }
                            .presentationDetents([.medium, .large])
                        }
                        .onAppear(){
                            Task{
                                await getData(link: dbLink, numId: usu)
                            }
                        }
                    }
                }
            }
            
        }
    }
    
    func postData(link : String, postData: DatoSeguir) async {
        guard let url = URL(string: link+"/agregadatoseguir") else {
            print("Wrong URL")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(postData) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        } catch {
            print("Check out failed: \(error.localizedDescription)")
        }
    }
    
    func getData(link : String, numId: Int) async {
        print("1--")
        guard let url = URL(string: link+"/datoshp/"+String(numId)) else {
            print("Wrong URL")
            return
        }
        print("2")
        do {
            print("in")
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode([DatoSeguir].self, from: data){
                let datos = decodedData
                datosList = datos
                print("success")
            }
        }
        catch {
            print("Error: Couldnt bring back data")
        }
        print("4")
    }
}

struct HPdatos_Previews: PreviewProvider {
    static var previews: some View {
        HPdatos()
    }
}
/*
 Image("Logo")
     .frame(width: geo.size.width, height: geo.size.height/2, alignment: .leading)
     .opacity(0.12)
 
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
     @State var tip = 0
     var datos = [
         DatoSeguir(idSintomaSeguir: 0, SeguirNombre: "Tos", SeguirFechaInicial: "", SeguirFechaFinal: "", ultimoRegistro: "", SeguirTipo: 0, Paciente_idPaciente: 0),
         DatoSeguir(idSintomaSeguir: 1, SeguirNombre: "Tos", SeguirFechaInicial: "", SeguirFechaFinal: "", ultimoRegistro: "", SeguirTipo: 0, Paciente_idPaciente: 0)
     ]
     let options = ["Tos", "Dolor de Cabeza", "Otro"]
     let tipoOpciones = ["Cualitativo", "Cuantitativo"]
     @State var tipo = ""
     @State var datoExtra = ""
     @State private var selectedOption = ""
     @AppStorage("usu") var usu = 0
     var body: some View {
         NavigationStack{
             ZStack{
                 Color("basic")
                     .ignoresSafeArea()
                 VStack{
                     Form{
                         ForEach(datos, id: \.self.idSintomaSeguir) { d in
                             Section{
                                 NavigationLink {
                                     DatoDetalle(dato: d)
                                 } label:{
                                     HStack{
                                         VStack(alignment: .leading){
                                             Text("Dato")
                                             Text(d.SeguirNombre)
                                                 .foregroundColor(.secondary)
                                                 .padding(.bottom, 5)
                                             Text("Ultimo Registro")
                                             Text(d.UltimoRegistro)
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
                         VStack{
                             Picker("picker", selection: $selectedOption) {
                                 ForEach(options, id: \.self){ opt in
                                     Text(opt)
                                 }
                             }
                             if (selectedOption == "Otro"){
                                 TextField("Dato a seguir", text: $datoExtra)
                                     .textFieldStyle(.roundedBorder)
                                     .padding()
                                 Picker("picker", selection: $tipo) {
                                     ForEach(tipoOpciones, id: \.self){ opt in
                                         Text(opt)
                                     }
                                 }
                             }
                             Button{
                                 if (selectedOption == "Otro"){
                                     selectedOption = datoExtra
                                 }
                                 
                                 if (tipo == "Cualitativo"){
                                     tip = 0
                                 } else {
                                     tip = 1
                                 }
                                 
                                 let datoS = DatoSeguir(idSintomaSeguir: 0, SeguirNombre: selectedOption, SeguirFechaInicial: "", SeguirFechaFinal: "", ultimoRegistro: "", SeguirTipo: tip, Paciente_idPaciente: usu)
                                 datoS.formatDate(Date())
                                 
                                 Task{
                                     await postData(postData: datoS)
                                 }
                                 alrt = false
                                 
                             } label: {
                                 Text("Agregar")
                             }
                         }
                         .presentationDetents([.medium, .large])
                     }
                 }
             }
         }
     }
     
     func postData(postData: DatoSeguir) async {
         guard let url = URL(string: "http://10.22.140.168:5000/agregadatoseguir") else {
             print("Wrong URL")
             return
         }
         
         guard let encoded = try? JSONEncoder().encode(postData) else {
             return
         }

         var request = URLRequest(url: url)
         request.httpMethod = "POST"
         request.setValue("application/json", forHTTPHeaderField: "Content-Type")
         
         do {
             let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
             
             if let responseString = String(data: data, encoding: .utf8) {
                 print("Response: \(responseString)")
             }
         } catch {
             print("Check out failed: \(error.localizedDescription)")
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

*/
