//
//  HPcalendariodatos.swift
//  RetoIOS
//
//  Created by Alumno on 10/11/23.
//

import SwiftUI

struct HPcalendariodatos: View {
    @State var selectedDay: String
    let dbLink = "http://10.22.129.138:5001"
    let selectedMonth: String
    @State var fecha = ""
    let selectedYear: Int
    @AppStorage("usu") var usu = 0
    @AppStorage ("JWT") var jwt = ""
    @State var registro = [
        RegistroDatos(idRegistroSintomas: 0, RegistroSintoma: "", RegistroIntensidad: 0, RegistroFecha: "", RegistroNota: "", Usuario_idUsuario: 0, SintomasSeguir_idSintomasSeguir: 0)
    ]
    @State var registros = [RegistroDatos]()
    @State private var isDetailPresented = false

        var body: some View {
            NavigationView {
                if (registros.isEmpty){
                    Text("No hay registros")
                        .font(.largeTitle)
                } else {
                    VStack{
                        Text("\(selectedDay) \(selectedMonth) "+String(selectedYear))
                            .padding()
                            .font(.largeTitle)
                        ScrollView(.vertical, showsIndicators: true) {
                            ForEach($registros){r in
                                NavigationLink{
                                } label: {
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                            .foregroundColor(Color("butts"))
                                        VStack(alignment: .leading){
                                            Text(r.RegistroSintoma.wrappedValue)
                                                .foregroundColor(Color("txt"))
                                                .padding(.horizontal)
                                            if (r.RegistroIntensidad.wrappedValue > 1){
                                                Text(roundedString(value: Double(r.RegistroIntensidad.wrappedValue), decimalPlaces: 2))
                                                    .padding(.bottom)
                                                    .padding(.horizontal)
                                                    .foregroundColor(Color("gry"))
                                                    
                                            } else {
                                                Slider(value:r.RegistroIntensidad)
                                                    .tint(accentColor(for: r.RegistroIntensidad))
                                                    .disabled(true)
                                                    .padding(.bottom)
                                                    .padding(.horizontal)
                                            }
                                            if r.RegistroNota.wrappedValue.count > 1{
                                                Text("Nota:")
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
                                        }
                                        .padding()
                                    }
                                    .padding(.horizontal, 20)
                                    .padding(5)
                                    .onTapGesture {
                                        if let index = registros.firstIndex(where: { $0.idRegistroSintomas == r.idRegistroSintomas.wrappedValue }) {
                                            registro = [registros[index]] // Assign the tapped RegistroDatos to `registro`
                                            isDetailPresented = true
                                        }
                                    }
                                }
                            }
                            .sheet(isPresented: $isDetailPresented) {
                                if !registro.isEmpty {
                                    DetalleDia(fecha: registro[0].RegistroFecha, intensidad: registro[0].RegistroIntensidad, nota: registro[0].RegistroNota)
                                }
                            }
                            //.navigationBarTitle(registro.RegistroSintoma)
                        }
                    }
                    //.navigationBarTitle("\(selectedDay) \(selectedMonth) \(String(format: "%04d", selectedYear))", displayMode: .inline)
                }
            }
            .onAppear(){
                if selectedDay == ""{
                    fecha = "2023-11-2"
                } else {
                    fecha = formattedDateString(ano: selectedYear, mes: selectedMonth, d: selectedDay)!
                }
                Task{
                    await getData(link: dbLink, numId: usu, fecha: fecha)
                }
            }
        }

    func formattedDateString(ano: Int, mes:String, d:String) -> String? {
        // Create a DateFormatter
        let dateFormatter = DateFormatter()
        print(ano)
        print(mes)
        print(d)

        dateFormatter.locale = Locale(identifier: "es")

        dateFormatter.dateFormat = "YYYY-MM-dd"

        if let date = dateFormatter.date(from: "\(ano)-\(mes)-\(d)") {
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func roundedString(value: Double, decimalPlaces: Int) -> String {
        return String(format: "%.\(decimalPlaces)f", value)
    }
    
    func getData(link: String, numId: Int, fecha: String) async {
        guard let url = URL(string: link + "/registrosDia/" + String(numId) + "/" + fecha) else {
            print("Wrong URL")
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Juan123", forHTTPHeaderField: "x-api-key")
        request.setValue("Bearer \(jwt)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedData = try? JSONDecoder().decode([RegistroDatos].self, from: data) {
                let datos = decodedData
                registros = datos
                print("success")
            }
        } catch {
            print("Error: Couldn't bring back data")
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

struct HPcalendariodatos_Previews: PreviewProvider {
    static var previews: some View {
        HPcalendariodatos(selectedDay: "2", selectedMonth: "Enero", selectedYear: 2023)
    }
}
