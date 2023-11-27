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
    var estatura : Int
    var genero : String
    
    init(nombre: String, apellido: String, fechanac: String, correo: String, telefono: Int, contrasena: String, estatura: Int, genero: String) {
        self.nombre = nombre
        self.apellido = apellido
        self.fechanac = fechanac
        self.correo = correo
        self.telefono = telefono
        self.contrasena = contrasena
        self.estatura = estatura
        self.genero = genero
    }
}
