//
//  HomeWorkPlannerApp.swift
//  Shared
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI

@main
struct HomeWorkPlannerApp: App {
    
    let persistenceContainer = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabItemView()
                .environment(\.managedObjectContext, persistenceContainer.container.viewContext)
        }
    }
}
