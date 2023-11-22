//
//  UltimosDias.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 08/11/23.
//  Juan logro que jale :)
//

import SwiftUI

struct UltimosDias: View {
    var dato : DatoSeguir
    @State var inte = 0.5
    @State private var regis = RegistroDatos(idRegistroSintomas: 0, RegistroSintoma: "", RegistroIntensidad: 0, RegistroFecha: "", RegistroNota: "", Usuario_idUsuario: 0, SintomasSeguir_idSintomasSeguir: 0)
    @State private var isDetailPresented = false
    @State var registro = [
        RegistroDatos(idRegistroSintomas: 0, RegistroSintoma: "", RegistroIntensidad: 0, RegistroFecha: "", RegistroNota: "", Usuario_idUsuario: 0, SintomasSeguir_idSintomasSeguir: 0)
    ]
    var body: some View {
        NavigationStack {
            VStack{
                ScrollView(.vertical, showsIndicators: true) {
                    ForEach($registro){r in
                        NavigationLink{
                        } label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color("butts"))
                                VStack{
                                    Text(r.RegistroFecha.wrappedValue)
                                        .foregroundColor(Color("txt"))
                                    Slider(value:r.RegistroIntensidad)
                                        .tint(accentColor(for: r.RegistroIntensidad))
                                        .disabled(true)
                                        .padding(.bottom)
                                        .padding(.horizontal)
                                    Text("Nota")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                        .foregroundColor(Color("txt"))
                                        .padding(.bottom, 1)
                                    
                                    Text(r.RegistroNota.wrappedValue)
                                        .multilineTextAlignment(.leading)
                                        .foregroundColor(Color("gry"))
                                        .lineLimit(2)
                                        .truncationMode(.tail)
                                        .padding(.horizontal)
                                    
                                }
                                .padding()
                            }
                            .padding(.horizontal, 20)
                            .padding(5)
                            .onTapGesture {
                                regis = r.wrappedValue
                                isDetailPresented = true
                            }
                        }
                    }
                    .sheet(isPresented: $isDetailPresented) {
                        DetalleDia(dato: regis)
                            .presentationDetents([.medium, .large])
                    }
                    .navigationBarTitle(dato.SeguirNombre)
                }
            }
            .background(Color("basic"))
        }
    }
    func accentColor(for value: Binding<Float>) -> Color {
            let floatValue = value.wrappedValue
            if floatValue < 0.33 {
                return .green
            } else if floatValue < 0.66 {
                return .yellow
            } else {
                return .red
            }
        }

}

struct UltimosDias_Previews: PreviewProvider {
    static var previews: some View {
        UltimosDias(dato: DatoSeguir(idSintomasSeguir: 0, SeguirNombre: "", SeguirTipo: 0, UltimoRegistro: "", SeguirFechaInicial: "", SeguirFechaFinal: "", Usuario_idUsuario: 0))
    }
}
