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
    let dblink = "http://10.22.129.138:5001"
    @State var registros = [RegistroDatos]()
    @State var registrosNull = [RegistroDatos(idRegistroSintomas: 1, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: " ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 1, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "   ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4),RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "    ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4), RegistroDatos(idRegistroSintomas: 2, RegistroSintoma: "_", RegistroIntensidad: 0.9 , RegistroFecha: "     ", RegistroNota: "_", Usuario_idUsuario: 3, SintomasSeguir_idSintomasSeguir: 4)]
    @State var alrt : Bool = false
    @AppStorage("usu") var usu = 0
    @State var homeP = false
    @AppStorage ("JWT") var jwt = ""
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
                                UltimosDias(registros: registros, dato: dato)
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
                                await finSintoma(link: "http://10.22.129.138:5001", idSintoma: dato.idSintomasSeguir)
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
                    await getRegistros(link:dblink, idUsu: usu,idSintoma:dato.idSintomasSeguir)
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
         
        
        var request = URLRequest(url: url)
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        print("2")
        do {
            print("in")
            let(data, _) = try await URLSession.shared.data(for: request)
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
    
    func finSintoma(link: String, idSintoma: Int) async {
        guard let url = URL(string: "\(link)/finSintoma/\(idSintoma)") else {
            print("Wrong URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            
        } catch {
            print("Error: Couldn't bring back data")
        }
    }

}

struct DatoDetalle_Previews: PreviewProvider {
    static var previews: some View {
        DatoDetalle(dato: DatoSeguir(idSintomasSeguir: 0, SeguirNombre: "", SeguirTipo: 0, UltimoRegistro: "", SeguirFechaInicial: "", SeguirFechaFinal: "", Usuario_idUsuario: 0))
    }
}
