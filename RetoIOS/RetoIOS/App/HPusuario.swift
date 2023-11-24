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
    @State var checkLogOut = false
    @State var Num_tel_Doctor = ""
    @State var peso = 1.1
    @State var estatura = 2.2
    @AppStorage("usu") var usu = 0
    @AppStorage("JWT") var jwt = ""
    
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
                                //correo
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
                                //cel
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
                                //peso
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("Peso", text: Binding(get: {
                                                                                "\(peso)"
                                                                            }, set: { newValue in
                                                                                if let value = Double(newValue) {
                                                                                    peso = value
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
                                            Text("Peso")
                                            TextField("Peso", text: Binding(get: {"\(peso)"
                                                                    }, set: { newValue in
                                                                        if let value = Double(newValue) {
                                                                            peso = value
                                                                        }
                                                                    }))
                                                .multilineTextAlignment(.trailing)
                                                .disabled(true)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                //estatura
                                HStack{
                                    NavigationLink{
                                        Form{
                                            Section{
                                                HStack{
                                                    TextField("Estatura", text: Binding(get: {
                                                                                "\(estatura)"
                                                                            }, set: { newValue in
                                                                                if let value = Double(newValue) {
                                                                                    estatura = value
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
                                            TextField("Estatura", text: Binding(get: {"\(estatura)"
                                                                    }, set: { newValue in
                                                                        if let value = Double(newValue) {
                                                                            estatura = value
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
                                    TextField("Dr bueno bueno", text: $Doctor)
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
                                logOut = true
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.clear)
                    }
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
