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
    var body: some View {
        VStack{
            Text("¿Cómo te sientes hoy?")
                .foregroundColor(.gray)
                .frame(width: 333, alignment: .leading)
                .padding()
                .font(.system(size: 25))
            Slider(value: $intensidad)
                .padding()
                .tint(accent)
                .onChange(of: intensidad) { newValue in
                    withAnimation (.easeOut(duration: 2)){
                        accent = accentColor(for: newValue)
                    }
                }
            Text("¿Cómo te sientes hoy?")
                .foregroundColor(.gray)
                .frame(width: 333, alignment: .leading)
                .padding()
                .font(.system(size: 25))
            Spacer()
        }
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
