//
//  ProfileView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 04.03.21.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        NavigationView {
   
            VStack {
                CardView(color: Color.green, headLine: "Fertige Aufgaben", bodyText: "Hier siehst du alle Aufgaben die du als erledigt markiert hast oder gelöscht hast.", desitination: AnyView(FinishHomeWorkView()))
                    .padding(.trailing, 3)
                    .padding(.leading, 3)
                
                Spacer()
            }
            
            .navigationTitle("Profil")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink("Einstellungen", destination: SettingsView())
                }
            })
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .preferredColorScheme(.dark)
    }
}
