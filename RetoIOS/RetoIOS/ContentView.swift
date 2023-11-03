//
//  ContentView.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 16/10/23.
//

import SwiftUI

struct ContentView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        ZStack{
            //Color(red: 200/255, green: 200/255, blue: 200/255)
            VStack {
                Text("Bienvenido")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 20.0)
                    .padding(.top, 20.0)
                    .frame(width: 333, alignment: .leading)
                NavigationStack{
                    Form{
                        Section{
                            HStack{
                                TextField(" ",text: $email)
                            }
                        }
                        header : {
                            Text("Correo")
                        }
                        Section{
                            HStack{
                                TextField(" ",text: $password)
                                
                            }
                        }
                        header : {
                            Text("Contraseña")
                        }
                    }
                    //.padding()
                }
                .frame(height: 220)
                    
                ButtonFill(contentTxt: "Iniciar Sesión", c:.blu)
                    .padding(.top, 15)
                Spacer()
                ButtonBlank(contentTxt: "Crear Cuenta", c:.blu)
                Text("J C S L")
                    .bold()
                    .padding(.top,0.5)

            }
        }
        .background(Color(red: 0.949, green: 0.949, blue: 0.971))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 //
 //  ContentView.swift
 //  RetoIOS
 //
 //  Created by Luis Eduardo Garza Naranjo on 16/10/23.
 //

 import SwiftUI

 struct ContentView: View {
     @State var email = ""
     @State var password = ""
     var body: some View {
         ZStack{
             VStack {
                 Text("Bienvenido")
                     .font(.largeTitle)
                     .fontWeight(.bold)
                     .padding(.bottom, 20.0)
                     .padding(.top, 20.0)
                     .frame(width: 333, alignment: .leading)
                 NavigationStack{
                     Form{
                         Section{
                             HStack{
                                 TextField(" ",text: $email)
                             }
                         }
                         header : {
                             Text("Correo")
                         }
                         Section{
                             HStack{
                                 TextField(" ",text: $password)
                                 
                             }
                         }
                         header : {
                             Text("Contraseña")
                         }
                     }
                     //.padding()
                 }
                 .frame(height: 220)
                     
                 ButtonFill(contentTxt: "Iniciar Sesión", c:.blu)
                     .padding(.top, 15)
                 Spacer()
                 ButtonBlank(contentTxt: "Crear Cuenta", c:.blu)
                 Text("J C S L")
                     .bold()
                     .padding(.top,0.5)

             }
         }
     }
 }

 struct ContentView_Previews: PreviewProvider {
     static var previews: some View {
         ContentView()
     }
 }

 /*
  //
  //  ContentView.swift
  //  RetoIOS
  //
  //  Created by Luis Eduardo Garza Naranjo on 16/10/23.
  //

  import SwiftUI

  struct ContentView: View {
      @State var userName = ""
      @State var password = ""
      var body: some View {
          ZStack{
              VStack {
                  Text("Bienvenido")
                      .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                      .fontWeight(.bold)
                      .frame(width: 333, alignment: .leading)
                  NavigationStack{
                      Form{
                          Section{
                              HStack{
                                  TextField("first name",text: $userName)
                              }
                          }
                          header : {
                              Text("Correo")
                          }
                          Section{
                              HStack{
                                  TextField("first name",text: $userName)
                              }
                          }
                          header : {
                              Text("Contraseña")
                          }
                      }
                  }
                  .frame(height: 200)
                      
                  ButtonFill(contentTxt: "Iniciar Sesión", c:.blu)
                  Spacer()
                  ButtonBlank(contentTxt: "Crear Cuenta", c:.blu)
                  Text("J C S L")
                      .bold()
                      .padding(.top,0.5)

              }
          }
      }
  }

  struct ContentView_Previews: PreviewProvider {
      static var previews: some View {
          ContentView()
      }
  }


  
  */

 
 */
