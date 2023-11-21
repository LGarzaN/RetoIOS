//
//  CrearCuenta1.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/2/23.
//
import SwiftUI


struct CrearCuenta1: View {
    @State var cellNum = ""
    @State var pswd1 = ""
    @State var pswd2 = ""
    @State var errorMsg = ""
    @State var error = false
    @State var next = false
    @State var user = Usuario(nombre: "", apellido: "", fecha: "", correo: "", contrasena: "", telefono: 0)
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
                                TextField("nombre",text: $user.nombre)
                            }
                            //Apellido
                            HStack{
                                TextField("apellido",text: $user.apellido)
                            }
                        }
                        header : {
                            Text("Nombre de Usuario")
                        }
                        Section{
                            //Correo Electronico
                            HStack{
                                TextField("correo",text: $user.correo)
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
                                TextField("contraseña",text: $pswd1)
                            }
                            //Confirmar Contraseña
                            HStack{
                                TextField("confirmar contraseña",text: $pswd2)
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    .navigationTitle("Cuenta")
                    Button {
                        if (user.nombre != "" && user.apellido != "" && user.correo != "" && cellNum != "" && pswd1 != ""){
                            if let psw = Int(cellNum){
                                user.telefono = psw
                            } else {
                                errorMsg = "Ingrese un telefono válido"
                                error = true
                            }
                            
                            if (pswd1 == pswd2){
                                next = true
                            } else {
                                errorMsg = "Las contraseñas no coinciden"
                                error = true
                            }
                        }
                        else {
                            errorMsg = "Llene todos los campos"
                            error = true
                        }
                    } label: {
                        ButtonBlank(contentTxt: "  Siguiente        ", c: .purp)
                    }
                    .fullScreenCover(isPresented : $next) {
                        CrearCuenta2(user: $user)
                    }
                    .alert(errorMsg, isPresented: $error) {
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
