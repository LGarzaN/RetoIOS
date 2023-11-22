//
//  CrearCuenta2.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/3/23.
//
import SwiftUI
import CryptoKit


struct CrearCuenta2: View {
    let dbLink = "http://10.22.129.138:5000"
    @State var FechaNac = Date()
    @State var peso = ""
    @State var estatura = ""
    @State var create = false
    @Binding var user : Usuario
    @AppStorage("usu") var usu = 0
    
    @StateObject var listaAntecedentes = ListaAntecedentes()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
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
                                TextField("peso",text: $peso)
                            }
                            //Estatura
                            HStack{
                                TextField("estatura",text: $estatura)
                            }
                        }
                        header : {
                            Text("Datos Generales")
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
                    user.contrasena = hashPassword(user.contrasena)
                    user.fechanac = formatDate(FechaNac)
                    Task{
                        await postData(link: dbLink, postData: user)
                    }
                    
                } label: {
                    ButtonFill(contentTxt: "Crear Cuenta", c: .purp)//85
                }
                .fullScreenCover(isPresented : $create) {
                    ContentView()
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
    
    func hashPassword(_ password: String) -> String {
        if let data = password.data(using: .utf8) {
            let hashed = SHA256.hash(data: data)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return ""
    }
    
    func formatDate(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    func postData(link : String, postData: Usuario) async {
        guard let url = URL(string: link+"/agregausuario") else {
            print("Wrong URL")
            return
        }
        
        guard let encoded = try? JSONEncoder().encode(postData) else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
            create = true
        } catch {
            print("Check out failed: \(error.localizedDescription)")
        }
    }

}

struct CrearCuenta2_Previews: PreviewProvider {
    static var previews: some View {
        CrearCuenta2(user: .constant(Usuario(nombre: "", apellido: "", fecha: "", correo: "", contrasena: "", telefono: 0)))
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
