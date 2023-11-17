//
//  Usuario.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 17/11/23.
//

import Foundation

class Usuario : Codable{
    var nombre : String
    var apellido : String
    var fechanac : String
    var correo : String
    var telefono : Int
    var contrasena : String

    
    init(nombre: String, apellido: String, fecha: String, correo: String, contrasena: String, telefono: Int) {
        self.nombre = nombre
        self.apellido = apellido
        self.fechanac = fecha
        self.correo = correo
        self.contrasena = contrasena
        self.telefono = telefono
    }
}
