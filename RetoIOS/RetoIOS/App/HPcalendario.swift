import SwiftUI

struct DiaCalendario: Identifiable {
    var id = UUID()
    var dia: Int
    var fecha: Date
}

struct HPcalendario: View {
    @State var mostrarDatos = false
    let columnLayout = Array(repeating: GridItem(.flexible(minimum: 20, maximum: 100)), count: 7)
    let dias = ["Dom", "Lun", "Mar", "Mier", "Jue", "Vie", "Sab"]
    let meses = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]

    @State var mesElegido = Calendar.current.component(.month, from: Date()) - 1
    @State var year = Calendar.current.component(.year, from: Date())

    var body: some View {
        VStack {
            Text("Calendario")
                .font(.title)
                .bold()

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding()

            VStack {
                Text("\(meses[mesElegido]) \(String(format: "%04d", year))")
                    .font(.title2)

                LazyVGrid(columns: columnLayout) {
                    ForEach(dias, id: \.self) { dia in
                        Text(dia)
                    }

                    let firstDayOfMonth = obtenerPrimerDiaDelMes(mes: mesElegido + 1, year: year)
                    let daysInMonth = obtenerDiasEnMes(mes: mesElegido + 1, year: year)
                    let emptySlots = Array(0..<firstDayOfMonth)
                    ForEach(emptySlots, id: \.self) { _ in
                        Text("")
                    }

                    ForEach(daysInMonth, id: \.self) { dia in
                        Button("\(dia)"){
                            mostrarDatos = true
                        }
                        .sheet(isPresented: $mostrarDatos){
                            HPcalendariodatos()
                        
                            Text(dia)
                                .frame(width: 30, height: 30)
                                .cornerRadius(15)
                        }
                    }
                }
                .padding()

                Picker("Selecciona un mes", selection: $mesElegido) {
                    ForEach(0..<12) { index in
                        Text(meses[index])
                    }
                }
                Picker("Selecciona un año", selection: $year) {
                    ForEach(2000...2030, id: \.self) { year in
                        Text(String(format: "%04d", year))
                    }
                }
            }
        }
    }

    func obtenerPrimerDiaDelMes(mes: Int, year: Int) -> Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = mes
        components.day = 1
        let date = calendar.date(from: components)!
        let firstWeekday = calendar.component(.weekday, from: date)
        return firstWeekday - 1
    }

    func obtenerDiasEnMes(mes: Int, year: Int) -> [String] {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = mes
        let date = calendar.date(from: components)!

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        var daysInMonth = [String]()
        for day in 1...31 {
            components.day = day
            if let dayDate = calendar.date(from: components),
               calendar.component(.month, from: dayDate) == mes {
                daysInMonth.append(dateFormatter.string(from: dayDate))
            }
        }
        return daysInMonth
    }
}

struct HPcalendario_Previews: PreviewProvider {
    static var previews: some View {
        HPcalendario()
    }
}





