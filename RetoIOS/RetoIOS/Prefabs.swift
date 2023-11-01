//
//  Prefabs.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 10/17/23.
//
import Foundation
import SwiftUI

//Buttons
struct ButtonBlank : View{
    var contentTxt : String
    var c : Color
    
    var body : some View {
        Button(action: {
            print("Supreme Leader Blank")
        }) {
            Text(contentTxt)
                .font(.title)
                .foregroundColor(c)
                .padding(.horizontal, 50.0)
                .padding(.vertical, 1)
                .overlay(
                    RoundedRectangle(cornerRadius: 90)
                        .stroke(c, lineWidth: 3)
                )
            }
    }
}

struct ButtonFill : View{
    var contentTxt : String
    var c : Color
    
    var body : some View {
        Button(action: {
            print("Supreme Leader Fill")
        }){
            Text(contentTxt)
        }
            .padding(.horizontal, 50.0)
            .padding(.vertical, 1)
            .font(.title)
            .foregroundColor(Color.white)
            .background(c)
            .cornerRadius(90)
        }
}

//Colors
extension Color {
    static let blu = Color(red: 0/255, green: 167/255, blue: 225/255)
    static let purp = Color(red: 218/255, green: 64/255, blue: 210/255)
    static let grn = Color(red: 44/255, green: 222/255, blue: 126/255)
}

/*
 struct ButtonBlank : View{
     var contentTxt : String
     var c : Color
     
     var body : some View {
         GeometryReader{ geo in
             Button(action: {
                 print(geo.size.height)
                 print(geo.size.width)
             }) {
                 Text(contentTxt)
                     .font(.title)
                     .foregroundColor(c)
                     .padding(.horizontal, 50.0)
                     .overlay(
                         RoundedRectangle(cornerRadius: 90)
                             .stroke(c, lineWidth: 3)
                     )
             }
         }
     }
 }
 */
