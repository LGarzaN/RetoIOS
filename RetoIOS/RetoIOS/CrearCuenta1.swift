//
//  CrearCuenta1.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/2/23.
//

import SwiftUI


struct CrearCuenta1: View {
    @State var fName = "hs"
    @State var lName = "max"
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    //Nombre
                    HStack{
                        NavigationLink{
                            Form{
                                Section{
                                    HStack{
                                        TextField(" ",text: $fName)
                                    }
                                }
                            }
                            .navigationTitle("Nombre(s)")
                            .navigationBarTitleDisplayMode(.inline)
                        }label:{
                            Text("Nombre(s)")
                        }
                    }
                    //Apellido
                    HStack{
                        NavigationLink{
                            NavigationStack{
                                Form{
                                    Section{
                                        HStack{
                                            TextField(" ",text: $lName)
                                        }
                                    }
                                }
                            }
                        }label:{
                            Text("Apellido")
                        }
                    }
                }
                header : {
                    Text("Nombre")
                }
                Section{
                    HStack{
                        //
                    }
                }
                header : {
                    Text("Datos")
                }
                Section{
                    HStack{
                        //
                    }
                }
                header : {
                    Text("Contraseña")
                }
            }
            //.padding()
            .navigationTitle("Cuenta")
        }
    }
}

struct CrearCuenta1_Previews: PreviewProvider {
    static var previews: some View {
        CrearCuenta1()
    }
}
