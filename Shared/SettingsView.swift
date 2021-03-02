//
//  SettingsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 01.03.21.
//

import SwiftUI

struct SettingsView: View {
    
    private var finalString: String = "Default value"
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Lege deine Lieblingseinstellungen fest.")
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                
            
            }
        }
        .navigationTitle("Einstellungen")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
