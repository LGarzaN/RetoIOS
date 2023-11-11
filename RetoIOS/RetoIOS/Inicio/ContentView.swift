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

                    Button {
                        enter = true
                    } label: {
                        ButtonFill(contentTxt: "Iniciar Sesión", c: .blu)
                    }
                    .fullScreenCover(isPresented : $enter) {
                        Homepage()
                    }
                    .padding(.bottom, 300)
                    //Spacer()
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

/*
 
 import SwiftUI
 
 struct ContentView: View {
 //#F1F1F7
 @State var email = ""
 @State var password = ""
 @State var enter = false
 var body: some View {
 ZStack{
 Color("basic")
 VStack {
 NavigationStack{
 Text("Bienvenido")
 .font(.largeTitle)
 .fontWeight(.bold)
 .padding(.bottom, 20.0)
 .padding(.top, 20.0)
 .frame(width: 333, alignment: .leading)
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
 Button {
 enter = true
 } label: {
 Text("Iniciar Sesión")
 .padding(.horizontal, 85.0)
 .padding(.vertical, 12)
 .font(.title)
 .foregroundColor(Color.white)
 .background(Color.blu)
 .cornerRadius(90)
 }
 .fullScreenCover(isPresented : $enter) {
 Homepage()
 }
 .padding(.bottom, 300)
 //Spacer()
 NavigationLink{
 CrearCuenta1()
 } label: {
 Text("Crear Cuenta")
 .font(.title)
 .foregroundColor(.blu)
 .padding(.horizontal, 85.0)
 .padding(.vertical, 10)
 .overlay(
 RoundedRectangle(cornerRadius: 90)
 .stroke(Color.blu, lineWidth: 3)
 )
 }
 Text("J C S L")
 .bold()
 .padding(.top,0.5)
 }
 }
 }
 }
 }
 
 struct ContentView_Previews: PreviewProvider {
 static var previews: some View {
 ContentView()
 }
 }
 */
