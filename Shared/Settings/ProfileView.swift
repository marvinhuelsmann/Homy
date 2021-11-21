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
                ShadowCardView(title: "Fertige Aufgaben", bodyText: "Hier siehst du alle Aufgaben die du als erledigt markiert hast oder gelöscht hast.", destination: AnyView(FinishHomeWorkView()), backgroundColor: UIBlurEffect(style: .systemMaterialDark), foregroundColor: .white, size: .medium)
                
                ShadowCardView(title: "Erfolge", bodyText: "Sehe dir deine Homy Erfolge an und lass dich feiern und bejubeln.", destination: AnyView(AchievementsListView()), backgroundColor: UIBlurEffect(style: .systemMaterialLight), foregroundColor: .black, size: Sizes.small)
                
            
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
