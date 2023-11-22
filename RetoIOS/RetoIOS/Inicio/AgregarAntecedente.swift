//
//  AddArticle.swift
//  AddValLists
//
//  Created by Juan Lebrija on 10/9/23.
//

import SwiftUI

struct AgregarAntecedente: View {
    @State var pID = 733
    @State var title = ""
    @State var contenido = ""
    @ObservedObject var listaAntecedentes : ListaAntecedentes
    @Environment(\.dismiss) var removeWindow
    @FocusState var keyboard : Bool
    @State var valnull = false
    @AppStorage("usu") var usu = 0
 
    var body: some View {
        NavigationView{
            Form {
                Section{
                    HStack{
                        TextField("",text: $title)
                    }
                }
                header : {
                    Text("Titulo")
                }
                Section{
                    HStack{
                        TextEditor(text: $contenido)
                            .frame(height: 200)
                    }
                }
                header : {
                    Text("Descripcion")
                }
                 
            }
            .navigationTitle("Antecedente")
            .toolbar{
                Button("Agregar"){
                    if title != "" && contenido != ""{
                        let nuevoAnt = Antecedente(idAntecedentes: 0, Titulo: title, Contenido: contenido, Usuario_idUsuario: usu)
                        listaAntecedentes.antecedentes.append(nuevoAnt)
                        
                        removeWindow()
                    }
                    else{
                        valnull = true
                    }
                }
                .font(.title3)
                .alert(isPresented: $valnull){
                    Alert(
                        title: Text("Error"),
                        message: Text("Llena todos los campos")
                        )
                }
            }
        }
    }
}

struct AgregarAntecedentes_Previews: PreviewProvider {
    static var previews: some View {
        AgregarAntecedente(listaAntecedentes : ListaAntecedentes())    }
}
