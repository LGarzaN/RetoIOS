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
    @AppStorage("usu") var usu = 0
    @State var alrt = false
    @State var tip = 0
    @State var datosList = [DatoSeguir]()
    @State var mat = [[RegistroDatos]]()
    let tipoOpciones = ["Cualitativo", "Cuantitativo"]
    @State var tipo = ""
    @State var datoExtra = ""
    @State private var selectedOption = ""
    @AppStorage ("API_KEY") var key = "Juan"
    @State var registros = [RegistroDatos]()
    @State var registrosNull = [RegistroDatos(idRegistroSintomas: 1, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: " ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 1, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "   ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "    ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4), RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "     ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4)]
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
                                                Text(d.SeguirNombre)
                                                    .padding(.bottom, 5)
                                                Text("Ultimo Registro")
                                                Text(d.UltimoRegistro)
                                                    .foregroundColor(.secondary)

                                            }
                                            .padding(.trailing, 10)
                                        
                                            Chart{
                                                if registros.count < 5{
                                                    ForEach(Array(registrosNull.suffix(5-registros.count)), id: \.self.idRegistroSintomas) { registro in
                                                        BarMark(x: .value("Dia",registro.RegistroFecha), y: .value("Que tan mal", registro.RegistroIntensidad), width: 10)
                                                        .foregroundStyle(.clear)
                                                    }
                                                    ForEach(Array(registros.suffix(5)), id: \.self.idRegistroSintomas) { registro in
                                                        BarMark(x: .value("Dia",registro.RegistroFecha), y: .value("Que tan mal", registro.RegistroIntensidad), width: 10)
                                                            
                                                    }
                                                }else{
                                                    ForEach(Array(registros.suffix(5)), id: \.self.idRegistroSintomas) { registro in
                                                        BarMark(x: .value("Dia",registro.RegistroFecha), y: .value("Que tan mal", registro.RegistroIntensidad), width: 10)
                                                            
                                                    }
                                                }
                                            }
                                            .frame(width: 120, height: 70)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                        }//form
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
                                Text("Nuevo Dato")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                                Form{
                                    Section{
                                        TextField("Dato a seguir", text: $datoExtra)
                                            
                                    }header : {
                                        Text("Nombre de dato")
                                    }
                                    Section{
                                        HStack{
                                            Picker(" ", selection: $tipo) {
                                                ForEach(tipoOpciones, id: \.self){ opt in
                                                    Text(opt)
                                                }
                                            }
                                            Spacer()
                                        }
                                    }header : {
                                        Text("Tipo de dato")
                                    }
                                }//form
                                Button{
                                    selectedOption = datoExtra
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
                                    ButtonBlank(contentTxt: "Agregar", c: .grn)
                                }//buttonLabel
                            }//vstack
                            .presentationDetents([.medium, .large])
                        }//sheet
                        .onAppear(){
                            Task {
                                await getData(link: dbLink, numId: usu)
                            }
                        }//onAppear
                    }//vStack
                }//zStack
            }//Navstack
        }//GeoReader
    }//body
    
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
        guard let url = URL(string: link+"/datoshp/"+String(numId)) else {
            print("Wrong URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode([DatoSeguir].self, from: data) {
                let datos = decodedData
                datosList = datos
                print(datosList)
            }
            
        } catch {
            print("Error: Couldn't bring back data")
        }
    }
    func getRegistros(link : String, idUsu: Int, idSintoma: Int) async {
        print("1--")
        guard let url = URL(string: "\(link)/registros/\(idUsu)/\(idSintoma)") else {
            print("Wrong URL")
            return
         }
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
}

struct HPdatos_Previews: PreviewProvider {
    static var previews: some View {
        HPdatos()
    }
}

/*
 Chart{
     LineMark(x: .value("Ciudad", "1"), y: .value("Poblacion", 4))
     LineMark(x: .value("Ciudad", "2"), y: .value("Poblacion", 7))
     LineMark(x: .value("Ciudad", "3"), y: .value("Poblacion", 2))
     LineMark(x: .value("Ciudad", "4"), y: .value("Poblacion", 10))
 }
 */
