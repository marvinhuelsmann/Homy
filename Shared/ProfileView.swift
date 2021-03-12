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
                CardView(color: Color.red, headLine: "Was ist Homy", bodyText: "Homy ist einer der leistungsstärksten Apps die es in der Kategorie lernen gibt.", desitination: AnyView(AddHomeWorkView()))
                
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
            .preferredColorScheme(.light)
    }
}
