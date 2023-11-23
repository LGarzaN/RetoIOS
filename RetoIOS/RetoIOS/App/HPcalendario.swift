import SwiftUI

struct DiaCalendario: Identifiable {
    var id = UUID()
    var dia: Int
    var fecha: Date
}

struct HPcalendario: View {
    @State var mostrarDatos = false
    let columnLayout = Array(repeating: GridItem(.flexible(minimum: 20, maximum: 100)), count: 7)
    let dias = ["Do", "Lu", "Ma", "Mi", "Ju", "Vi", "Sa"]
    let meses = ["En", "Feb", "Mzo", "Abr", "Myo", "Jun", "Jul", "Ago", "Sept", "Oct", "Nov", "Dic"]

    @State var mesElegido = Calendar.current.component(.month, from: Date()) - 1
    @State var year = Calendar.current.component(.year, from: Date())
    @State var diaElegido = ""

    var body: some View {
        GeometryReader{geo in
            NavigationStack{
                ZStack{
                    Color("basic")
                        .ignoresSafeArea()
                    Image("Logo")
                        .frame(width: geo.size.width, height: geo.size.height/2, alignment: .leading)
                        .opacity(0.12)
                    VStack{
                        HStack{
                            //month
                            Menu{
                                Picker(selection: $mesElegido) {
                                    ForEach(0..<12) { index in
                                        Text(meses[index])
                                            .tag(index)
                                    }
                                }label: {}
                            }label: {
                                Text(meses[mesElegido])
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20.0)
                                    .padding(.top, 20.0)
                                    .foregroundColor(.blu)
                                    .padding(.leading)
                            }
                            //year
                            Menu{
                                Picker(selection: $year) {
                                    ForEach(2000...2030, id: \.self) { year in
                                        Text(String(format: "%04d", year))
                                            .tag(year)
                                    }
                                }label: {}
                            }label: {
                                Text(String(format: "%04d", year))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 20.0)
                                    .padding(.top, 20.0)
                                    .foregroundColor(.blu)
                            }
                            Spacer()
                        }
                        VStack{
                            LazyVGrid(columns: columnLayout) {
                                ForEach(dias, id: \.self) { dia in
                                    Text(dia)
                                        .bold()
                                }

                                let firstDayOfMonth = obtenerPrimerDiaDelMes(mes: mesElegido + 1, year: year)
                                let daysInMonth = obtenerDiasEnMes(mes: mesElegido + 1, year: year)
                                let emptySlots = Array(0..<firstDayOfMonth)
                                ForEach(emptySlots, id: \.self) { _ in
                                    Text("")
                                }

                                ForEach(daysInMonth, id: \.self) { dia in
                                    VStack{
                                        Rectangle()
                                            //.frame(width: 54, height: 0.7)
                                            .frame(width: geo.size.width/7, height: 0.7)
                                            .foregroundColor(.blu)
                                        Button(action: {
                                            mostrarDatos = true
                                            diaElegido = dia
                                        }, label: {
                                            Text("\(dia)")
                                                .foregroundColor(.primary)
                                        })
                                        .sheet(isPresented: $mostrarDatos){
                                            HPcalendariodatos(selectedDay: diaElegido, selectedMonth: meses[mesElegido], selectedYear: year)
                                        }
                                    }
                                    .padding(.bottom, 30)
                                }
                            }
                            .padding(.horizontal)
                            Spacer()
                        }
                        .frame(height: 424)
                        HStack(alignment: .center){
                            Button(action: {
                                mesElegido -= 1
                                if mesElegido < 0 {
                                    mesElegido = meses.count - 1
                                    year -= 1
                                }
                            }) {
                                Image(systemName: "arrow.left.circle")
                                    .font(.title)
                                    .foregroundColor(.blu)
                            }
                            .padding(.leading, 30)
                            Spacer()
                            Button(action: {
                                mesElegido += 1
                                if mesElegido >= meses.count {
                                    mesElegido = 0
                                    year += 1
                                }
                            }) {
                                Image(systemName: "arrow.right.circle")
                                    .font(.title)
                                    .foregroundColor(.blu)
                            }
                            .padding(.trailing, 30)
                        }
                        Spacer()
                    }
                }
                .navigationTitle("Calendario")
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
        _ = calendar.date(from: components)!

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
