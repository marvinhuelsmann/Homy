//
//  SettingsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 04.03.21.
//

import SwiftUI

struct SettingsView: View {
    
    /// AppSettings
    @AppStorage("secureOnLogin") var requiredPasswordIdOnLogin = false
    @AppStorage("notifications") var allowNotifications = true
    @AppStorage("firstAppOpen") var firstAppOpen = false
    
    @State private var showSubjectView = false

    var body: some View {
        
        VStack {
            Form {
                
                Section(header: Text("Allgemein"), footer: Text("Aktiviere um \(getBiometricTypeName()) beim öffnen der App zu aktivieren. Achtung: Fallst du dich nicht mehr identifizieren kannst gehen die Daten verloren!")) {
                    Toggle(getBiometricTypeName(), isOn: $requiredPasswordIdOnLogin)
                }
                
                Section(footer: Text("Erhalte Töne wenn du deine Aufgabe den Abgabe Termin erreicht.")) {
                    Toggle("Benachrichtigung", isOn: $allowNotifications)
                }
                
                Section(footer: Text("Erstelle ein neues Fach um es deinen Hausaufgaben zu teilen zu könne.")) {
                    NavigationLink(destination: SubjectListView()) {
                        VStack {
                            Text("Fächer")
                        }
                        .onTapGesture {
                            showSubjectView = true
                        }
                    }
                    
                }
                
                
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
