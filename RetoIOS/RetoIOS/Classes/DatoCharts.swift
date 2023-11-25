//
//  DatoCharts.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/24/23.
//

import Foundation

class DatoCharts : Identifiable, Codable{
    var RegistroFecha : String
    var RegistroIntensidad : Float
    var SintomasSeguir_idSintomasSeguir : Int
   
    init(RegistroFecha: String, RegistroIntensidad: Float, SintomasSeguir_idSintomasSeguir: Int) {
        self.RegistroFecha = RegistroFecha
        self.RegistroIntensidad = RegistroIntensidad
        self.SintomasSeguir_idSintomasSeguir = SintomasSeguir_idSintomasSeguir
    }
}
