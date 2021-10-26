//
//  TabView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI
import LocalAuthentication

struct TabItemView: View {
    /// if the app is unlocked
    @State private var isUnlocked = false
    /// if the informations view from the app will be showed
    @State private var showInformationsView = !SettingsView().firstAppOpen
    
    var body: some View {
        VStack {
                TabView {
                    WorkListView()
                        .tabItem {
                            Image(systemName: "books.vertical")
                            Text("Hausaufgaben")
                        }
                    
                    SubjectListView()
                        .tabItem {
                            Image(systemName: "text.book.closed")
                            Text("Fächer")
                        }
                    
                    TimeTableView()
                        .tabItem {
                            Image(systemName: "tablecells")
                            Text("Stundenplan")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profil")
                        }
                }.blur(radius: self.isUnlocked || !SettingsView().requiredPasswordIdOnLogin ? 0 : 17)
        }
        .onAppear(perform: authenticate)
        .sheet(isPresented: $showInformationsView, content: {
            InformationsView()
        }).onAppear(perform: {
            SettingsView().firstAppOpen = true
        })
    }
    
    /// To authenticate the user with the app
    func authenticate() {
        if SettingsView().requiredPasswordIdOnLogin {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) || context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
                let reason = "Um deine gespeicherten Hausaufgaben anzeigen zu lassen."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    DispatchQueue.main.async {
                        if success {
                            isUnlocked = true
                        } else {
                            isUnlocked = false
                        }
                    }
                }
            } else {
                isUnlocked = false
            }
        }
    }
    
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView()
    }
}
