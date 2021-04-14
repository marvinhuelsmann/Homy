//
//  AchivementsListView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 21.03.21.
//

import SwiftUI
import CoreData

struct AchievementsListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    /// List of all current finish HomeWorks in FinishWorkData
    private var achievements: FetchedResults<AchievementsData>
    
    var body: some View {
        VStack {
            VStack {
                List {
                    if self.achievements.isEmpty {
                        Text("Bis jetzt hast du noch keine Erfolge sammeln können, nutze weiter die App!")
                    }
                    
                    
                    ForEach(achievements) { achievement in
                        HStack {
                            Spacer()
                            AchievementsDetail(achivement: achievement)
                            Spacer()
                        }
                    }
                    
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Erfolge")
                
            }
            
            Spacer()
        }
    }
}

struct AchivementsListView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsListView()
            .previewDevice("iPhone 12 Pro")
    }
}

/// The detail view of one HomeWork in the list
struct AchievementsDetail: View {
    var achivement: AchievementsData
    var body: some View {
        
        AchievementCardView(type: achivement.name!, headLine: achivement.name!, bodyText: achivement.level!)
        
    }
}
