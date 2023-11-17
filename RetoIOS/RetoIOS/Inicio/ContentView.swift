//
//  ContentView.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 16/10/23.
//                Color("basic")
//.ignoresSafeArea()

import SwiftUI
import Foundation
import CryptoKit

struct DataModel : Codable{
    var contrasena : String
    var idUsuario : Int
}

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State var enter = false
    @State var alrta = false
    @State var alrtaMsg = ""
    @State var pass = DataModel(contrasena: "hi", idUsuario: 1)
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                   .ignoresSafeArea()
                VStack{
                    Image("Logo")
                        .resizable()
                        .frame(width: 200, height: 110)
                        .padding(.top, 50)
                    Form{
                        Section{
                            HStack{
                                TextField(" ",text: $email)
                                    .autocapitalization(.none)
                            }
                        }
                        header : {
                            Text("Correo")
                        }
                        Section{
                            HStack{
                                TextField(" ",text: $password)
                                    .autocapitalization(.none)
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    .scrollDisabled(true)
                    Button {
                        Task{
                            await loadData(correo: email)
                        }
                        if (hashPassword(password) == pass.contrasena){
                            enter = true
                        }
                        else {
                            alrtaMsg = "Datos incorrectos"
                            alrta = true
                        }
                    } label: {
                        ButtonFill(contentTxt: "Iniciar Sesión", c: .blu)
                    }
                    .fullScreenCover(isPresented : $enter) {
                        Homepage()
                    }
                    .alert(alrtaMsg, isPresented: $alrta){
                    }
                    .padding(.bottom, 300)
                    NavigationLink{
                        CrearCuenta1()
                    } label: {
                        ButtonBlank(contentTxt: "Crear Cuenta", c: .grn)
                    }
                    Text("J C S L")
                        .bold()
                        .padding(.top,0.5)
                }
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        }
        //.navigationTitle("hi")
    }
    
    func hashPassword(_ password: String) -> String {
        if let data = password.data(using: .utf8) {
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return ""
    }
    
    func loadData(correo:String) async {
        guard let url = URL(string: "http://10.22.133.47:5000/usuario/"+correo) else {
            print("Wrong URL")
            return
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            if let decodedData = try? JSONDecoder().decode([DataModel].self, from: data){
                let pa = decodedData
                if pa.count > 0{
                    print(pa[0].contrasena)
                    pass = pa[0]
                }
                else{
                    alrtaMsg = "correo no registrado"
                }

            }
        }
        catch {
            print("Error: Couldnt bring back data")
        }
    }
}

extension UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
