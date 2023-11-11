//
//  Homepage.swift
//  RetoIOS
//
//  Created by Luis Eduardo Garza Naranjo on 01/11/23.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        TabView {
            HPdatos()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }

            HPcalendario()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tint(.purp)

            HPusuario()
                .tabItem {
                    Image(systemName: "person")
                        .foregroundColor(Color.white)
                    Text("Profile")
                }
        }
        .tint(.grn)
    }
}

struct Homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
