//
//  ComoTeSientes.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 03/11/23.
//

import SwiftUI

struct ComoTeSientes: View {
    @State var intensidad = 0.0
    @State var accent : Color = .black
    @State var nota : String = ""
    @State var fecha : Date = Date()
    var body: some View {
        VStack{
            Text("¿Cómo te sientes hoy?")
                .foregroundColor(.gray)
                .frame(width: 333, alignment: .leading)
                .padding()
                .font(.system(size: 25))
            Slider(value: $intensidad)
                .padding(.horizontal, 30)
                .padding(.bottom, 15)
                .tint(accentColor(for: intensidad))
            Form{
                Section{
                    TextEditor(text: $nota)
                        .frame(height: 150)
                        .padding()
                } header: {
                    Text("Notas")
                }
                Section{
                    HStack{
                        DatePicker("Fecha", selection: $fecha, displayedComponents: .date)
                    }
                }
            }
            Button {
                //code
            } label: {
                ButtonBlank(contentTxt: "   Guardar      ", c: .purp)
            }
            Spacer()
        }
        .background(Color("basic"))
    }
    
    func accentColor(for value: Double) -> Color {
        if value < 0.33 {
            return .green
        } else if value < 0.66 {
            return .yellow
        } else {
            return .red
        }
    }
}

struct ComoTeSientes_Previews: PreviewProvider {
    static var previews: some View {
        ComoTeSientes()
    }
}
