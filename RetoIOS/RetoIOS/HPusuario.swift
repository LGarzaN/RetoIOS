//
//  HPusuario.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI

struct HPusuario: View {
    @State var nombre = ""
    @State var apellidos = ""
    @State var correo = ""
    @State var Num_tel_Usuario = ""
    @State var Doctor = ""
    @State var Num_tel_Doctor = ""
    var opciones = ["Sintomas" , "Calendario", "Usuario"]
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    HStack{
                        NavigationLink{
                            Form{
                                Section{
                                    HStack{
                                        TextField("Luis pancho", text: $nombre)
                                    }
                                }
                            }
                            .navigationTitle("Nombre")
                            .navigationBarTitleDisplayMode(.inline)
                        }label:{
                            Text("Nombre                              \(nombre)")
                        }
                    }
                    HStack{
                        NavigationLink{
                            Form{
                                Section{
                                    HStack{
                                        TextField("Garza Garza", text: $apellidos)
                                    }
                                }
                            }
                            .navigationTitle("Apellidos")
                            .navigationBarTitleDisplayMode(.inline)
                        }label:{
                            Text("Apellidos                              \(apellidos)")
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
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                    }
                    HStack{
                        Text("Num Cel.")
                        TextField("81 23 45 67 89", text: $Num_tel_Doctor)
                            .textFieldStyle(.roundedBorder)
                            .disabled(true)
                    }
                }header: {
                    Text("Datos del Doctor")
                }
                
            }
            .navigationTitle("Usuario")
        }
    }
}

struct HPusuario_Previews: PreviewProvider {
    static var previews: some View {
        HPusuario()
    }
}
