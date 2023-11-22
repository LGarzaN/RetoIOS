//
//  DatoSeguir.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 03/11/23.
//

import Foundation


class DatoSeguir : Identifiable, Codable{
    var idSintomasSeguir: Int
    var SeguirNombre: String
    var SeguirTipo : Int
    var UltimoRegistro: String
    var SeguirFechaInicial: String
    var SeguirFechaFinal: String
    var Usuario_idUsuario: Int
   
    init(idSintomasSeguir: Int, SeguirNombre: String, SeguirTipo: Int, UltimoRegistro: String, SeguirFechaInicial: String, SeguirFechaFinal: String, Usuario_idUsuario: Int) {
        self.idSintomasSeguir = idSintomasSeguir
        self.SeguirNombre = SeguirNombre
        self.SeguirTipo = SeguirTipo
        self.UltimoRegistro = UltimoRegistro
        self.SeguirFechaInicial = SeguirFechaInicial
        self.SeguirFechaFinal = SeguirFechaFinal
        self.Usuario_idUsuario = Usuario_idUsuario
    }
    
    func formatDate(_ date: Date) -> Void {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return formatter
        }()
        
        self.UltimoRegistro = dateFormatter.string(from: date)
        self.SeguirFechaFinal = dateFormatter.string(from: date)
        self.SeguirFechaInicial = dateFormatter.string(from: date)

    }
    
    
    
}
/*
 
 class DatoSeguir : Identifiable, Codable{
     var idSintomaSeguir : Int
     var SeguirNombre : String
     var SeguirFechaInicial : String
     var SeguirFechaFinal : String
     var UltimoRegistro : String
     var SeguirTipo : Int
     var Paciente_idPaciente : Int
     
     init(idSintomaSeguir: Int, SeguirNombre: String, SeguirFechaInicial: String, SeguirFechaFinal: String, ultimoRegistro: String, SeguirTipo: Int, Paciente_idPaciente: Int) {
         self.idSintomaSeguir = idSintomaSeguir
         self.SeguirNombre = SeguirNombre
         self.SeguirFechaInicial = SeguirFechaInicial
         self.SeguirFechaFinal = SeguirFechaFinal
         self.UltimoRegistro = ultimoRegistro
         self.SeguirTipo = SeguirTipo
         self.Paciente_idPaciente = Paciente_idPaciente
     }
     
     func formatDate(_ date: Date) -> Void {
         let dateFormatter: DateFormatter = {
             let formatter = DateFormatter()
             formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
             return formatter
         }()
         
         self.UltimoRegistro = dateFormatter.string(from: date)
         self.SeguirFechaFinal = dateFormatter.string(from: date)
         self.SeguirFechaInicial = dateFormatter.string(from: date)

     }
     
 }

 */
