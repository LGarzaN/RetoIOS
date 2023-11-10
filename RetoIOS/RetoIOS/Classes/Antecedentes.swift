//
//  Antecedentes.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/3/23.
//

import Foundation

struct Antecedente: Identifiable{
    var id = UUID()
    var titulo : String
    var content : String
    var patientId : Int
}

class ListaAntecedentes : ObservableObject{
    @Published var antecedentes = [Antecedente]()
}
