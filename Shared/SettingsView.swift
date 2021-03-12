//
//  SettingsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 04.03.21.
//

import SwiftUI

struct SettingsView: View {
    
    /// Choose themes
    private var localDesigns = [AppDesigns.DARK.rawValue, AppDesigns.LIGHT.rawValue, AppDesigns.AUTOMATIC.rawValue]
    
    /// AppSettings
    @AppStorage("secureOnLogin") var requiredPasswordIdOnLogin = false
    @AppStorage("notifications") var allowNotifications = true
    @AppStorage("appDesgin") var appDesign = AppDesigns.AUTOMATIC.rawValue
    
    var body: some View {
            VStack {
                Form {
                    
                    Section(header: Text("Allgemein"), footer: Text("Aktiviere um FaceID beim öffnen der App zu aktivieren. Achtung: Fallst du dich nicht mehr identifizieren kannst gehen die Daten verloren!")) {
                        Toggle("FaceID", isOn: $requiredPasswordIdOnLogin)
                    }
                    
                    Section(footer: Text("Erhalte Töne wenn du deine Aufgabe den Abgabe Termin erreicht.")) {
                        Toggle("Benachrichtigung", isOn: $allowNotifications)
                    }
                    
                    Picker(selection: $appDesign, label: Text("Anzeige")) {
                        ForEach(localDesigns, id: \.self) {
                            Text($0)
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
