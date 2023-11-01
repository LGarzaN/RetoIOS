//
//  ContentView.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 16/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            VStack {
                Text("Bienvenido")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.leading)
                    
                ButtonFill(contentTxt: "Iniciar Sesión", c:.purp)
                Spacer()
                ButtonBlank(contentTxt: "Crear Cuenta", c:.blu)
                Text("J C S L")
                    .bold()
                    .padding(.top,0.5)

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

