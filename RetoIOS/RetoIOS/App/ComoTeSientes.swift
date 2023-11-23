//
//  ComoTeSientes.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 03/11/23.
//

import SwiftUI

struct ComoTeSientes: View {
    var dato : DatoSeguir
    @State var intensidad = 0.0
    @State var accent : Color = .black
    @State var nota : String = ""
    @State var fecha : Date = Date()
    @State var alerta = false
    @State var cont = ""
    @State var added = false
    @State var reg = RegistroDatos(idRegistroSintomas: 0, RegistroSintoma: "", RegistroIntensidad: 0, RegistroFecha: "", RegistroNota: "", Usuario_idUsuario: 0, SintomasSeguir_idSintomasSeguir: 0)
    
    var body: some View {
        VStack{
            Text("¿Cómo te sientes hoy?")
                .foregroundColor(.gray)
                .frame(width: 333, alignment: .leading)
                .padding()
                .font(.system(size: 25))
            Slider(value: $intensidad)
                .padding(.horizontal, 30)
                .padding(.bottom, 15)
                .tint(accentColor(for: intensidad))
            Form{
                Section{
                    TextEditor(text: $nota)
                        .frame(height: 150)
                        .padding()
                } header: {
                    Text("Notas")
                }
                Section{
                    HStack{
                        DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                    }
                }
            }
            Button {
                if(intensidad == 0){
                    alerta = true
                    cont = "No modificó la intensidad ¿Desea Continuar?"
                }
                
                else if (nota == ""){
                    alerta = true
                    cont = "No agregó una nota, ¿Desea Continuar?"
                }
                else{
                    reg.RegistroIntensidad = Float(intensidad)
                    reg.RegistroSintoma = dato.SeguirNombre
                    reg.RegistroNota = nota
                    reg.Usuario_idUsuario = dato.Usuario_idUsuario
                    reg.SintomasSeguir_idSintomasSeguir = dato.idSintomasSeguir
                    reg.RegistroFecha = formatDate(fecha)
                    Task{
                        await postData(link: "http://10.22.129.138:5000", postData: reg)
                    }
                    added = true
                }
            } label: {
                ButtonBlank(contentTxt: "   Guardar      ", c: .purp)
            }
            .padding()
            .alert(cont, isPresented: $alerta) {
                Button("Regresar", role: .cancel) {}
                Button("Continuar") {
                    reg.RegistroIntensidad = Float(intensidad)
                    reg.RegistroSintoma = dato.SeguirNombre
                    reg.RegistroNota = nota
                    reg.Usuario_idUsuario = dato.Usuario_idUsuario
                    reg.SintomasSeguir_idSintomasSeguir = dato.idSintomasSeguir
                    reg.RegistroFecha = formatDate(fecha)
                    Task{
                        await postData(link: "http://10.22.129.138:5000", postData: reg)
                    }
                    added = true
                }
            }
            .fullScreenCover(isPresented : $added) {
                Homepage()
            }
        }
        .background(Color("basic"))
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
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
        return dateFormatter.string(from: date)
    }
    
    func postData(link : String, postData: RegistroDatos) async {
        guard let url = URL(string: link+"/agregaregistro") else {
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

struct ComoTeSientes_Previews: PreviewProvider {
    static var previews: some View {
        ComoTeSientes(dato: DatoSeguir(idSintomasSeguir: 0, SeguirNombre: "", SeguirTipo: 0, UltimoRegistro: "", SeguirFechaInicial: "", SeguirFechaFinal: "", Usuario_idUsuario: 0))
    }
}
