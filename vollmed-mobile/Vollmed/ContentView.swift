//
//  ContentView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var authManager = AuthenticationManager.shared
    
    var body: some View {
        
        if authManager.getToken() == nil {
            NavigationStack{
                SignInView()
            }
        } else {
            TabView {
                NavigationStack{
                    HomeView()
                }.tabItem {
                    Label(title: {Text("Home")}, icon: {Image(systemName: "house")})
                }
                NavigationStack{
                    MyAppointmentView()
                }.tabItem {
                    Label(title: {Text("Minhas consultas")}, icon: {Image(systemName: "calendar")})
                }
            }.toolbar{
                toolbar
            }
        }
    }
    
    var toolbar: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button(action: {
                Task {
                    authManager.logout()
                }
            }, label: {
                HStack(spacing: 2) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                    Text("Logout")
                }
            })
        }
    }
    
    
}

#Preview {
    ContentView()
}
