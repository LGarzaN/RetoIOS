//
//  HPdatos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI
import Charts

struct HPdatos: View {
    let dbLink = "http://10.22.129.138:5001"
    @State var alrt = false
    @State private var animate: Bool = false
    @State var tip = 0
    @State var datosList = [DatoSeguir]()
    let tipoOpciones = ["Cualitativo", "Cuantitativo"]
    @State var tipo = ""
    @State var datoExtra = ""
    @State private var selectedOption = ""
    @AppStorage ("API_KEY") var key = "Juan"
    @State var registros = [DatoCharts]()
    //@State var registrosNull = [DatoCharts(RegistroFecha: " ", RegistroIntensidad: 0.9, SintomasSeguir_idSintomasSeguir: 69),DatoCharts(RegistroFecha: "  ", RegistroIntensidad: 0.9, SintomasSeguir_idSintomasSeguir: 69),DatoCharts(RegistroFecha: "   ", RegistroIntensidad: 0.9, SintomasSeguir_idSintomasSeguir: 69),DatoCharts(RegistroFecha: "    ", RegistroIntensidad: 0.9, SintomasSeguir_idSintomasSeguir: 69),DatoCharts(RegistroFecha: "     ", RegistroIntensidad: 0.9, SintomasSeguir_idSintomasSeguir: 69)]
    @AppStorage("usu") var usu = 0
    @AppStorage ("JWT") var jwt = ""
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
                                            Chart {
                                                ForEach(Array(registros), id: \.id) { registro in
                                                    if registro.SintomasSeguir_idSintomasSeguir == d.idSintomasSeguir{
                                                        BarMark(x: .value("Dia", registro.RegistroFecha), y: .value("Que tan mal", registro.RegistroIntensidad), width: 10)
                                                    }
                                                }
                                            }
                                            .frame(width: 120, height: 70)
                                        }
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                            .onAppear {
                                withAnimation {
                                    animate = true
                                }
                            }
                            .opacity(animate ? 1 : 0)
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
                                            .padding(.trailing, 120)
                                        }
                                    }header : {
                                        Text("Tipo de dato")
                                    }
                                }//form
                                Button{
                                    selectedOption = datoExtra
                                    if (tipo == "Cualitativo"){
                                        tip = 1
                                    } else {
                                        tip = 0
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
                                await getChartsData(link: dbLink, usuId: usu)
                                sortRegistros()
                            }
                        }//onAppear
                    }//vStack
                }//zStack
            }//Navstack
        }//GeoReader
    }//body
    
    func postData(link : String, postData: DatoSeguir) async {
        guard let url = URL(string: link+"/agregadatoseguir/?jwt=\(jwt)") else {
            print("Wrong URL")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(postData) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        } catch {
            print("Check out failed: \(error.localizedDescription)")
        }
    }
    
    func getData(link: String, numId: Int) async {
        guard let url = URL(string: link + "/datoshp/" + String(numId)) else {
            print("Wrong URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedData = try? JSONDecoder().decode([DatoSeguir].self, from: data) {
                let datos = decodedData
                datosList = datos
                print(datosList)
            }
        } catch {
            print("Error: Couldn't bring back data")
        }
    }
    
    func getChartsData(link: String, usuId: Int) async {
        print("fme")
        guard let url = URL(string: link + "/getcharts/" + String(usuId)) else {
            print("Wrong URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        print("lemme")
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedData = try? JSONDecoder().decode([DatoCharts].self, from: data) {
                let datos = decodedData
                registros = datos
                print(registros)
                print("yay")
            }
        } catch {
            print("Error: Couldn't bring back data")
        }
    }
    func sortRegistros() {
        registros.sort { $0.SintomasSeguir_idSintomasSeguir < $1.SintomasSeguir_idSintomasSeguir }
    }
    func createMatrix() -> [Int: [DatoCharts]] {
            var matrix: [Int: [DatoCharts]] = [:]

            for registro in registros {
                let id = registro.SintomasSeguir_idSintomasSeguir
                
                if matrix[id] != nil {
                    matrix[id]?.append(registro)
                } else {
                    matrix[id] = [registro]
                }
            }

            return matrix
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

 ForEach(Array(datosList.enumerated()), id:\.d){index, d in
     await getRegistros(link: dbLink, idUsu: usu, idSintoma: d.idSintomasSeguir, inde: index)
 }
 ForEach(datosList, id:\.self){d in
     await getRegistros(link: dbLink, idUsu: usu, idSintoma: d.idSintomasSeguir)
 }
 
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
 */
