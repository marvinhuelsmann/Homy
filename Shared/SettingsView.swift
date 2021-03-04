//
//  SettingsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 04.03.21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("secureOnLogin") var requiredPasswordIdOnLogin = false
    @AppStorage("notifications") var allowNotifications = true
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Datenschutz & Sicherheit")) {
                    Toggle("FaceID", isOn: $requiredPasswordIdOnLogin)
                      
                
        
                }
                
                Section(header: Text("Töne & Benachrichtigungen")) {
                    Toggle("Benachrichtigung", isOn: $allowNotifications)
                }
            }
        }
        
        .navigationTitle("Einstellungen")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
