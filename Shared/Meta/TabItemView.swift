//
//  TabView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI

struct TabItemView: View {
    var body: some View {
        
        TabView {
            WorkListView()
                .tabItem {
                    Image(systemName: "books.vertical")
                    Text("Hausaufgaben")
                }
            
            NewsView()
                .tabItem {
                    Image(systemName: "network")
                    Text("Neuigkeiten")
                }
        }
        
    }
}

struct TabItemView_Previews: PreviewProvider {
    static var previews: some View {
        TabItemView()
    }
}
