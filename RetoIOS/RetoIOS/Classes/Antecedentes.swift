//
//  Antecedentes.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/3/23.
//

import Foundation

struct Antecedente: Codable{
    var idAntecedentes : Int
    var Titulo : String
    var Contenido : String
    var Usuario_idUsuario : Int
    
    init(idAntecedentes: Int, Titulo: String, Contenido: String, Usuario_idUsuario: Int) {
        self.idAntecedentes = idAntecedentes
        self.Titulo = Titulo
        self.Contenido = Contenido
        self.Usuario_idUsuario = Usuario_idUsuario
    }
}

class ListaAntecedentes : ObservableObject{
    @Published var antecedentes = [Antecedente]()
}
