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
/*
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
     @State var diaElegido = ""

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
                             diaElegido = dia
                         }
                         .sheet(isPresented: $mostrarDatos){
                             HPcalendariodatos(selectedDay: diaElegido, selectedMonth: meses[mesElegido], selectedYear: year)
                         
                 //            Text(dia)
                   //              .frame(width: 30, height: 30)
                     //            .cornerRadius(15)
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






 */
