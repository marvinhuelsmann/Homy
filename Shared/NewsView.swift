//
//  NewsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI

struct NewsView: View {
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                   
                    Text("\(Image(systemName: "arrow.turn.down.right")) Erster Blick")
                        .bold()
                        .padding(.leading, 40)
                        .padding(.top)
                        .font(.title2)
                    
                    Spacer()
                }
                
                Text("Dein erster Blick sollte wenn du Effizienten arbeiten willst die verschiedenen Aufgaben sein.")
                    .foregroundColor(.secondary)
                    .padding(.leading, 40)
                    .padding(.trailing)
                    .multilineTextAlignment(.leading)
                
                CardView(color: Color(UIColor.gray), headLine: "Besser lernen.", bodyText: "Hier erfährst du alles rund ums besser lernen, welche Strategien du Anwenden kannst oder mit was du deine Aufgaben schneller bearbeiten kannst.", desitination: AnyView(LearnGoodView()))
                    .padding(.top, 30)
                    .padding(.trailing, 10)
                    .padding(.leading, 10)
                
                CardView(color: Color.blue, headLine: "Perfomant arbeiten.", bodyText: "Du wolltest immer der sein. Der immer seine Aufgaben als erster abgibt? Dann versuch perfomanter zu lernen!", desitination: AnyView(LearnPerfomanceView()))
                    .padding(.top, 10)
                    .padding(.trailing)
                    .padding(.leading)
                
                
                Spacer()
                
            }
            
            .navigationTitle("Neuigkeiten")
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .preferredColorScheme(.light)
    }
}
