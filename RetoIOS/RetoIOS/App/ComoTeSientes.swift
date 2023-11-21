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
    @State var alerta = false
    @State var cont = ""
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
                if(intensidad == 0){
                    alerta = true
                    cont = "No modificó la intensidad ¿Desea Continuar?"
                }
                
                else if (nota == ""){
                    alerta = true
                    cont = "No agregó una nota, ¿Desea Continuar?"
                }
            } label: {
                ButtonBlank(contentTxt: "   Guardar      ", c: .purp)
            }
            .padding()
            .alert(cont, isPresented: $alerta) {
                Button("Regresar", role: .cancel) {}
                Button("Continuar") {}
            }
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
