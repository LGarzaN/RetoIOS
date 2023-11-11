//
//  ContentView.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 16/10/23.
//                Color("basic")
//.ignoresSafeArea()

import SwiftUI
import Foundation


struct ContentView: View {
    @State var email = ""
    @State var password = ""
    @State var enter = false
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
                            }
                        }
                        header : {
                            Text("Correo")
                        }
                        Section{
                            HStack{
                                TextField(" ",text: $password)
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    .scrollDisabled(true)
                    Button {
                        enter = true
                    } label: {
                        ButtonFill(contentTxt: "Iniciar Sesión", c: .blu)
                    }
                    .fullScreenCover(isPresented : $enter) {
                        Homepage()
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
