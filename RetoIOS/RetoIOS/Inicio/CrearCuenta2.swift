//
//  CrearCuenta2.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/3/23.
//
import SwiftUI


struct CrearCuenta2: View {
    @State var FechaNac = Date()
    @State var peso = ""
    @State var estatura = ""
    @State var create = false
    
    @StateObject var listaAntecedentes = ListaAntecedentes()
    
    @State var tryAddArticle = false
    var body: some View {
        ZStack{
            VStack{
                NavigationStack{
                    Form{
                        Section{
                            //FechaNac
                            HStack{
                                DatePicker("Fecha de Nacimiento", selection: $FechaNac, displayedComponents: .date)
                            }
                            //Peso
                            HStack{
                                Text("Peso")
                                TextField("peso",text: $peso)
                            }
                            //Estatura
                            HStack{
                                TextField("estatura",text: $estatura)
                            }
                        }
                        header : {
                            Text("Datos")
                        }
                        Section{
                            ForEach(listaAntecedentes.antecedentes){ ant in
                                Text(ant.titulo)
                            }
                            .onDelete(perform: deleteArticle)
                            HStack{
                                Button{
                                    tryAddArticle = true
                                } label: {
                                    HStack{
                                        Text("Agragar...")
                                        Image(systemName: "plus")
                                    }
                                }
                            }
                        }
                        header : {
                            Text("Antecedentes")
                        }
                        .sheet(isPresented: $tryAddArticle, content: {
                            AgregarAntecedente(listaAntecedentes: listaAntecedentes)
                        })
                    }
                    .navigationTitle("Cuenta")
                }
                Button {
                    create = true
                } label: {
                    ButtonFill(contentTxt: "Crear Cuenta", c: .purp)//85
                }
                .fullScreenCover(isPresented : $create) {
                    Homepage()
                }
                Text("J C S L")
                    .bold()
                    .padding(.top,0.5)
            }
        }
        .background(Color("basic"))
    }
    func deleteArticle(at offsets:IndexSet){
        listaAntecedentes.antecedentes.remove(atOffsets: offsets)
    }//func close
}

struct CrearCuenta2_Previews: PreviewProvider {
    static var previews: some View {
        CrearCuenta2()
    }
}

/*
 
 struct CrearCuenta2: View {
     @State var FechaNac = Date()
     @State var peso = ""
     @State var estatura = ""
     @StateObject var listaAntecedentes = ListaAntecedentes()
     @State var tryAddArticle = false
     var body: some View {
         NavigationStack{
             Form{
                 Section{
                     //FechaNac
                     HStack{
                         DatePicker("Fecha de Nacimiento", selection: $FechaNac, displayedComponents: .date)
                     }
                     //Peso
                     HStack{
                         Text("Peso")
                         TextField("peso",text: $peso)
                     }
                     //Estatura
                     HStack{
                         TextField("estatura",text: $estatura)
                     }
                 }
                 header : {
                     Text("Datos")
                 }
                 Section{
                     List{
                         ForEach(listaAntecedentes.antecedentes){ ant in
                             Text(ant.title)
                         }
                     }
                     HStack{
                         Button{
                             tryAddArticle = true
                         } label: {
                             HStack{
                                 Text("Agragar...")
                                 Image(systemName: "plus")
                             }
                         }
                     }//hstack
                 }
                 header : {
                     Text("Antecedentes")
                 }
                 .sheet(isPresented: $tryAddArticle, content: {
                     AgregarAntecedente(listaAntecedentes: listaAntecedentes)
                 })
             }
             .navigationTitle("Cuenta")
             Spacer()
             ButtonBlank(contentTxt: "Siguiente", c:.purp)
             Text("J C S L")
                 .bold()
                 .padding(.top,0.5)
         }
     }
 }

 struct CrearCuenta2_Previews: PreviewProvider {
     static var previews: some View {
         CrearCuenta2()
     }
 }

 */
