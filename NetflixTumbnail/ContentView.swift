//
//  ContentView.swift
//  NetflixTumbnail
//
//  Created by JIHYUN on 6/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView{
            // Text("one tab")
            HomeView() // 화면 불러옴  
                .tabItem{
                    Image(systemName: "house.fill")
                    Text("HOME")
                }
            
            // 탭 아이템 보이게
            .toolbarBackground(Color.black, for: .tabBar)
            
            
            Text("two tab")
                .tabItem {
                    Image(systemName: "gamecontroller.fill")
                    Text("GAME")
                }
            
            Text("three tab")
                .tabItem {
                    Image(systemName: "play.rectangle.fill")
                    Text("VIDEO")
                }
            
            Text("four tab")
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("MY")
                }
            
        } // tabview
        
        
    }
    
}

#Preview {
    ContentView()
}
