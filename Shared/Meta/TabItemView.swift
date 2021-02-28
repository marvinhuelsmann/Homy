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
            if self.isUnlocked {
                TabView {
                    WorkListView()
                        .tabItem {
                            Image(systemName: "books.vertical")
                            Text("Hausaufgaben")
                        }
                    
                    NewsView()
                        .tabItem {
                            Image(systemName: "network")
                            Text("Neuigkeiten")
                        }
                }
            }
        }
        .onAppear(perform: authenticate)
        
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Um deine Daten anzeigen zu lassen."
            
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

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView()
    }
}
