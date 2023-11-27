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
    var correo : String
}

struct Response : Codable{
    var JW_token : String
    var idUsuario : Int
    /*
     var NombreUsuario : String
     var ApellidoUsuario : String
     var Fecha_Nacimiento : String
     var CorreoUsuario : String
     var TelefonoUsuario : Int
     */
}

struct ContentView: View {
    let dbLink = "http://10.22.129.138:5001"
    @State var email = ""
    @State var password = ""
    @State var enter = false
    @State var alrta = false
    @State var alrtaMsg = ""
    @AppStorage("usu") var usu = 0
    @AppStorage("JWT") var jwt = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                   .ignoresSafeArea()
                VStack{
                    Image("Logo")
                        .resizable()
                        .frame(width: 110, height: 110)
                        .padding(.top, 50)
                    Form{
                        Section{
                            HStack{
                                TextField(" ",text: $email)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                                    .textContentType(.emailAddress)
                            }
                        }
                        header : {
                            Text("Correo")
                        }
                        Section{
                            HStack{
                                SecureField(" ",text: $password)
                                    .autocapitalization(.none)
                                    .autocorrectionDisabled()
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    .scrollDisabled(true)
                    .frame(height: 200)
                    Button {
                        Task{
                            await postData(link:dbLink, postData: DataModel(contrasena: hashPassword(password), correo: email))
                            if (jwt != "" && usu != 0){
                                enter = true
                            } else {
                                alrtaMsg = "Datos Incorrectos"
                                alrta = true
                            }
                        }

                    } label: {
                        ButtonFill(contentTxt: "Iniciar Sesión", c: .blu)
                    }
                    .alert(alrtaMsg, isPresented: $alrta){
                    }
                    .fullScreenCover(isPresented : $enter) {
                        Homepage()
                    }
                    //.padding(.bottom, 300)
                    Spacer()
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
    }
    
    func hashPassword(_ password: String) -> String {
        if let data = password.data(using: .utf8) {
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return ""
    }
    
    func postData(link : String, postData: DataModel) async {
        guard let url = URL(string: link+"/login") else {
            print("Wrong URL")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(postData) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Juan123", forHTTPHeaderField: "X-API-Key")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            if let decodedData = try? JSONDecoder().decode(Response.self, from: data){
                let pa = decodedData
                usu = pa.idUsuario
                jwt = pa.JW_token
                print(jwt)
            } else {
                alrtaMsg = "Datos Incorrectos"
                alrta = true
            }
            
        } catch {
            print("Check out failed: \(error.localizedDescription)")
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
/*
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
     let dbLink = "http://10.22.129.138:5001"
     @State var email = ""
     @State var password = ""
     @State var enter = false
     @State var alrta = false
     @State var alrtaMsg = ""
     @State var pass = DataModel(contrasena: "hi", idUsuario: 1)
     @AppStorage("usu") var usu = 0
     var body: some View {
         NavigationStack{
             ZStack{
                 Color("basic")
                    .ignoresSafeArea()
                 VStack{
                     Image("Logo")
                         .resizable()
                         .frame(width: 110, height: 110)
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
                     .frame(height: 200)
                     Button {
                         Task{
                             await loadData(link: dbLink,correo: email)
                         }
                         if (hashPassword(password) == pass.contrasena){
                             usu = pass.idUsuario
                             enter = true
                         }
                         else {
                             alrtaMsg = "Datos incorrectos"
                             alrta = true
                         }
                     } label: {
                         ButtonFill(contentTxt: "Iniciar Sesión", c: .blu)
                     }
                     .alert(alrtaMsg, isPresented: $alrta){
                     }
                     //.padding(.bottom, 300)
                     Spacer()
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
     }
     
     func hashPassword(_ password: String) -> String {
         if let data = password.data(using: .utf8) {
             let hashed = SHA256.hash(data: data)
             return hashed.compactMap { String(format: "%02x", $0) }.joined()
         }
         return ""
     }
     
     func loadData(link : String, correo:String) async {
         guard let url = URL(string: link+"/usuario/"+correo) else {
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

 */
