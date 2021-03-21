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
                
                CardView(color: Color.blue, headLine: "Erfolge", bodyText: "Sehe dir deine Homy Erfolge an und lass dich feiern und bejubeln.", desitination: AnyView(AchievementsListView()))
                    .padding(.trailing, 15)
                    .padding(.leading, 15)
                    .padding(.top, 10)
                
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
