//
//  datos.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 02/11/23.
//

import Foundation


class registroDatos : Identifiable{
    var id : Int
    var nombre : String
    var fecha : Date
    var intensidad : Float
    var nota : String
    
    init(id: Int, nombre: String, fecha: Date, intensidad: Float, nota: String) {
        self.id = id
        self.nombre = nombre
        self.fecha = fecha
        self.intensidad = intensidad
        self.nota = nota
    }
    
}
