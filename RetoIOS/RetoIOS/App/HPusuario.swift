//
//  HPusuario.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI

struct datosp : Codable{
    var apellidousuario : String
    var correousuario : String
    var estatura : Int
    var nombreusuario : String
    var telefonousuario : Int

}

struct HPusuario: View {
    @State var correo = "correo@mail.mx"
    @State var Num_tel_Usuario = "81 23 45 67 89"
    let dbLink = "http://10.22.139.63:5001"
    @State var Doctor = ""
    @State var d = datosp(apellidousuario: "", correousuario: " ", estatura: 0, nombreusuario: " ", telefonousuario: 0)
    @State var logOut = false
    @State var checkLogOut = false
    @State var Num_tel_Doctor = ""
    @AppStorage("usu") var usu = 0
    @AppStorage("JWT") var jwt = ""
    @AppStorage("nombre") var nombre = ""
    @AppStorage("apellidos") var apellidos = ""
    @AppStorage("Estatura") var estatura = 0
    
    var opciones = ["Sintomas" , "Calendario", "Usuario"]
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
                            Section{
                                //nombre
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("nombre", text: $d.nombreusuario)
                                                }
                                            }
                                        }
                                        .navigationTitle("Nombre")
                                        .navigationBarTitleDisplayMode(.inline)
                                    }label:{
                                        HStack{
                                            Text("Nombre")
                                            TextField("\(nombre)", text: $d.nombreusuario)
                                                .multilineTextAlignment(.trailing)
                                                .disabled(true)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                //apellido
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("apellido", text: $d.apellidousuario)
                                                }
                                            }
                                        }
                                        .navigationTitle("Apellido")
                                        .navigationBarTitleDisplayMode(.inline)
                                    }label:{
                                        HStack{
                                            Text("Apellido")
                                            TextField("\(apellidos)", text: $d.apellidousuario)
                                                .multilineTextAlignment(.trailing)
                                                .disabled(true)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                
                            } header: {
                                Text("Datos del usuario")
                            }
                            
                            Section{
                                //correo
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("LuisPancho@gmail.com", text: $d.correousuario)
                                                }
                                            }
                                        }
                                        .navigationTitle("correo")
                                        .navigationBarTitleDisplayMode(.inline)
                                    }label:{
                                        Text("Correo")
                                    }
                                }
                                //cel
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("cel", text: Binding(get: {
                                                        "\(d.telefonousuario)"
                                                                            }, set: { newValue in
                                                                                if let value = Int(newValue) {
                                                                                    d.telefonousuario = value
                                                                                }
                                                                            }))
                                                        .keyboardType(.decimalPad)
                                                }
                                            }
                                        }
                                        .navigationTitle("Numero de telefono")
                                        .navigationBarTitleDisplayMode(.inline)
                                    }label:{
                                        Text("# de telefono")
                                    }
                                }
                                
                            } header: {
                                Text("Datos del contacto")
                            }
                            Section{
                                //estatura
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("Estatura", text: Binding(get: {
                                                        "\(d.estatura)"
                                                                            }, set: { newValue in
                                                                                if let value = Int(newValue) {
                                                                                    d.estatura = value
                                                                                }
                                                                            }))
                                                        .keyboardType(.decimalPad)
                                                }
                                            }
                                        }
                                        .navigationTitle("Nombre")
                                        .navigationBarTitleDisplayMode(.inline)
                                    }label:{
                                        HStack{
                                            Text("Estatura")
                                            TextField("Estatura", text: Binding(get: {"\(d.estatura)"
                                                                    }, set: { newValue in
                                                                        if let value = Int(newValue) {
                                                                            d.estatura = value
                                                                        }
                                                                    }))
                                                .multilineTextAlignment(.trailing)
                                                .disabled(true)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            }header : {
                                Text("Datos Generales")
                            }
                            Section{
                                //dr nombre
                                HStack{
                                    Text("Dr")
                                    TextField("Dr Gonzalez Guerra", text: $Doctor)
                                        .disabled(true)
                                        .multilineTextAlignment(.trailing)
                                }
                                //dr num
                                HStack{
                                    Text("Num Cel.")
                                    TextField("81 23 45 67 89", text: $Num_tel_Doctor)
                                        .multilineTextAlignment(.trailing)
                                        .disabled(true)
                                }
                            }header: {
                                Text("Datos del Doctor")
                            }
                            Section{
                                HStack{
                                    Button{
                                        checkLogOut = true
                                    } label: {
                                        Text("Cerrar Sesión")
                                            .foregroundColor(.purp)
                                    }
                                }
                            }
                        }
                        .navigationTitle("Usuario")
                        .fullScreenCover(isPresented : $logOut) {
                            ContentView()
                        }
                        .alert("¿Está seguro que desea Cerrar Sesión?", isPresented: $checkLogOut) {
                            Button("Cancelar", role: .cancel) {}
                            Button("Cerrar Sesión", role: .destructive) {
                                usu = 0
                                jwt = ""
                                nombre = ""
                                apellidos = ""
                                estatura = 0
                                logOut = true
                            }
                        }
                        .onAppear(){
                            if (nombre == "" || apellidos == ""){
                                Task{
                                    await getData(link: dbLink, numId: usu)
                                }
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
                }
            }
        }
    }
    
    func getData(link: String, numId: Int) async {
        print("1")
        guard let url = URL(string: link + "/getAlgo/" + String(numId)) else {
            print("Wrong URL")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        print("2")
        do {
            print("2.5")
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedData = try? JSONDecoder().decode([datosp].self, from: data) {
                let datos = decodedData
                print(datos)
                print("3")
                d = datos[0]
            }
        } catch {
            print("Error: Couldn't bring back data")
        }
        print("4")
    }
}

struct HPusuario_Previews: PreviewProvider {
    static var previews: some View {
        HPusuario()
    }
}
/*
 .alert("¿Está seguro que desea eliminar este dato?", isPresented: $alrt) {
     Button("Cancelar", role: .cancel) {}
     Button("Eliminar", role: .destructive) {}
 }
 
 Section{
     HStack{
         Button{
             usu = 0
             logOut = true
         } label: {
             Text("Cerrar Sesión")
                 .foregroundColor(.purp)
         }
     }
 }
 Image("Logo")
     .frame(width: geo.size.width, height: geo.size.height/2, alignment: .leading)
     .opacity(0.15)
 */
