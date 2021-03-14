//
//  TabView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI
import LocalAuthentication

struct TabItemView: View {
    @State private var isUnlocked = false
    
    var body: some View {
        
        VStack {
            if self.isUnlocked || !SettingsView().requiredPasswordIdOnLogin  {
                TabView {
                    WorkListView()
                        .tabItem {
                            Image(systemName: "books.vertical")
                            Text("Hausaufgaben")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profil")
                        }
                }
            } else {
                VStack {
                Text("Passwortschutz")
                    .bold()
                    .font(.largeTitle)
                Text("Deine Daten sind mit \(getBiometricTypeName()) geschütz. Um auf die Daten zu greifen zu können musst du dich mit FaceID identifizieren.")
                    .padding(.trailing)
                    .padding(.leading)
                    
                    Spacer()
                }
                .padding(.top, 100)
            }
        }
        .onAppear(perform: authenticate)
        
    }
    
    func authenticate() {
        if SettingsView().requiredPasswordIdOnLogin {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
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
