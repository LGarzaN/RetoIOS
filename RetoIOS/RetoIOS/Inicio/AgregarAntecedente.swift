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
                        let nuevoAnt = Antecedente(titulo: title, content: contenido, patientId: pID)
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
