//
//  datos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 02/11/23.
//

import Foundation


class RegistroDatos : Identifiable, Codable{
    var idRegistroSintomas : Int
    var RegistroSintoma : String
    var RegistroIntensidad : Float
    var RegistroFecha : String
    var RegistroNota : String
    var Usuario_idUsuario : Int
    var SintomasSeguir_idSintomasSeguir : Int
    
    init(idRegistroSintomas: Int, RegistroSintoma: String, RegistroIntensidad: Float, RegistroFecha: String, RegistroNota: String, Usuario_idUsuario: Int, SintomasSeguir_idSintomasSeguir: Int) {
        self.idRegistroSintomas = idRegistroSintomas
        self.RegistroSintoma = RegistroSintoma
        self.RegistroIntensidad = RegistroIntensidad
        self.RegistroFecha = RegistroFecha
        self.RegistroNota = RegistroNota
        self.Usuario_idUsuario = Usuario_idUsuario
        self.SintomasSeguir_idSintomasSeguir = SintomasSeguir_idSintomasSeguir
    }
}
