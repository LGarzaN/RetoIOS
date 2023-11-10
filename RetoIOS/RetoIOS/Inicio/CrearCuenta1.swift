//
//  CrearCuenta1.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/2/23.
//
import SwiftUI


struct CrearCuenta1: View {
    @State var fName = ""
    @State var lName = ""
    @State var email = ""
    @State var cellNum = ""
    var body: some View {
        NavigationStack{
            ZStack{
                Color("basic")
                    .ignoresSafeArea()
                VStack{
                    Form{
                        Section{
                            //Nombre
                            HStack{
                                TextField("nombre",text: $fName)
                            }
                            //Apellido
                            HStack{
                                TextField("apellido",text: $lName)
                            }
                        }
                        header : {
                            Text("Nombre de Usuario")
                        }
                        Section{
                            //Correo Electronico
                            HStack{
                                TextField("correo",text: $fName)
                            }
                            //Num Celular
                            HStack{
                                TextField("# celular",text: $cellNum)
                            }
                        }
                        header : {
                            Text("Datos de Usuario")
                        }
                        Section{
                            //Contraseña
                            HStack{
                                TextField("contraseña",text: $fName)
                            }
                            //Confirmar Contraseña
                            HStack{
                                TextField("confirmar contraseña",text: $cellNum)
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    .navigationTitle("Cuenta")
                    NavigationLink{
                        CrearCuenta2()
                    } label: {
                        ButtonBlank(contentTxt: "  Siguiente        ", c: .purp)
                    }
                    Text("J C S L")
                        .bold()
                        .padding(.top,0.5)
                }
            }
        }
    }
}

struct CrearCuenta1_Previews: PreviewProvider {
    static var previews: some View {
        CrearCuenta1()
    }
}

/*
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

 */
