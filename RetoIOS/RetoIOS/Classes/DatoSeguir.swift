//
//  DatoSeguir.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 03/11/23.
//

import Foundation


class DatoSeguir : Identifiable, Codable{
    var id : Int
    var nombreDato : String
    var fechaIni : Date
    var fechaFin : Date
    var ultimoRegistro : Date
    var tipo : Int
    var idPaciente : Int
    
    init(id: Int, nombreDato: String, fechaIni: Date, fechaFin: Date, ultimoRegistro: Date, tipo: Int, idPaciente: Int) {
        self.id = id
        self.nombreDato = nombreDato
        self.fechaIni = fechaIni
        self.fechaFin = fechaFin
        self.ultimoRegistro = ultimoRegistro
        self.tipo = tipo
        self.idPaciente = idPaciente
    }
    
}
