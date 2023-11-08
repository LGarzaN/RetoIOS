//
//  SplashScreenView.swift
//  RetoIOS
//
//  Created by Juan Lebrija on 11/8/23.
//


import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    var body: some View {
        if isActive{
            ContentView()
        }else{
            ZStack{
                Color("basic")
                VStack{
                    VStack{
                        Image(systemName: "apple.logo")
                            .font(.system(size: 80))
                            .foregroundColor(.blu)
                        Text("J C S L")
                            .bold()
                            .font(.system(size: 22))
                            .foregroundColor(.blu)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 3.2)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                        withAnimation{
                            self.isActive = true
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

