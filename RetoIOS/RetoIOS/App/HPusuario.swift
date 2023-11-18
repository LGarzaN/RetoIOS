//
//  HPusuario.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI

struct HPusuario: View {
    @State var nombre = "Juan"
    @State var apellidos = "Lebrija"
    @State var correo = "a01721659@tec.mx"
    @State var Num_tel_Usuario = "81 23 45 67 89"
    @State var Doctor = ""
    @State var logOut = false
    @State var Num_tel_Doctor = ""
    @AppStorage("usu") var usu = 0
    var opciones = ["Sintomas" , "Calendario", "Usuario"]
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                   .ignoresSafeArea()
                VStack{
                    Form{
                        Section{
                            //nombre
                            HStack{
                                NavigationLink{
                                    Form{
                                        Section{
                                            HStack{
                                                TextField("nombre", text: $nombre)
                                            }
                                        }
                                    }
                                    .navigationTitle("Nombre")
                                    .navigationBarTitleDisplayMode(.inline)
                                }label:{
                                    HStack{
                                        Text("Nombre")
                                        TextField("\(nombre)", text: $nombre)
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
                                                TextField("apellido", text: $apellidos)
                                            }
                                        }
                                    }
                                    .navigationTitle("Apellido")
                                    .navigationBarTitleDisplayMode(.inline)
                                }label:{
                                    HStack{
                                        Text("Apellido")
                                        TextField("\(apellidos)", text: $apellidos)
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
                            HStack{
                                NavigationLink{
                                    Form{
                                        Section{
                                            HStack{
                                                TextField("LuisPancho@gmail.com", text: $correo)
                                            }
                                        }
                                    }
                                    .navigationTitle("correo")
                                    .navigationBarTitleDisplayMode(.inline)
                                }label:{
                                    Text("Correo")
                                }
                            }
                            HStack{
                                NavigationLink{
                                    Form{
                                        Section{
                                            HStack{
                                                TextField("81 89 67 56 78", text: $Num_tel_Usuario)
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
                            HStack{
                                Text("Dr")
                                TextField("Dr bueno bueno", text: $Doctor)
                                    .disabled(true)
                                    .multilineTextAlignment(.trailing)
                            }
                            HStack{
                                Text("Num Cel.")
                                TextField("81 23 45 67 89", text: $Num_tel_Doctor)
                                    .multilineTextAlignment(.trailing)
                                    .disabled(true)
                            }
                        }header: {
                            Text("Datos del Doctor")
                        }
                        
                    }
                    .navigationTitle("Usuario")
                    .scrollDisabled(true)
                    Button{
                        usu = 0
                        logOut = true
                    } label: {
                        Text("Cerrar Sesión")
                    }
                    .fullScreenCover(isPresented : $logOut) {
                        ContentView()
                    }
                    
                    Image("Logo")
                        .resizable()
                        .frame(width: 200, height: 110)
                        .padding(.bottom, 60)
                }
            }
        }
    }
}

struct HPusuario_Previews: PreviewProvider {
    static var previews: some View {
        HPusuario()
    }
}
