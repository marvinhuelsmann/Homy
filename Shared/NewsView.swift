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
            ScrollView {
                
                Text("amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolo")
                    .foregroundColor(.secondary)
                    .padding(.leading)
                    .padding(.trailing)
                    .multilineTextAlignment(.leading)
                
                CardView(color: Color(UIColor.gray), headLine: "Besser lernen.", bodyText: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et", desitination: AnyView(LearnGoodView()))
                    .padding(.top, 30)

                CardView(color: Color.blue, headLine: "Perfomant lernen.", bodyText: "Lorem ipsum dolor sit amet, consetetur, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At ver", desitination: AnyView(LearnPerfomanceView()))
                    .padding(.top, 10)
                
            }
            .padding(.trailing)
            .padding(.leading)
            
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
