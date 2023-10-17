//
//  ContentView.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 16/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("xdd")
            Button {
                //hola
            } label: {
                Text("Boton")
            }
            .padding()
            .background(Color.gray)
            .padding()
            //.roundedBorder()
                
            Button(action: {
                print("Hello button tapped!")
            }) {
                Text("Crear Cuenta")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.horizontal, 50.0)
                    .overlay(
                        RoundedRectangle(cornerRadius: 90)
                            .stroke(Color.blue, lineWidth: 3)
                    )
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
