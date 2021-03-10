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
            VStack {
                Form {
                    
                    Section(header: Text("Allgemein"), footer: Text("Aktiviere um FaceID beim öffnen der App zu aktivieren.")) {
                        Toggle("FaceID", isOn: $requiredPasswordIdOnLogin)
                    }
                    
                    Section(footer: Text("Erhalte Töne wenn du deine Aufgabe abgeben musst.")) {
                        Toggle("Benachrichtigung", isOn: $allowNotifications)
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
