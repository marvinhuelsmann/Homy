//
//  AchievementsHandler.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 21.03.21.
//

import SwiftUI
import CoreData

struct AchievementsHandler {
    @Environment(\.managedObjectContext) var viewContext
    
    /// Save the Context
    func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// To format the Achievements
    /// - Parameters:
    ///   - type: Achievement Type
    ///   - count: the amount of the CoreData
    ///   - viewContext: to save the Data
    func setAchievements(type: AchievementsType, count: Int, viewContext: NSManagedObjectContext) {
        
        if type == AchievementsType.homeWorkList {
            if count == 5 {
                setAchievement(name: "5 Hausaufgaben", level: "Einsteiger", viewContext: viewContext)
            } else if count == 15 {
                setAchievement(name: "15 Hausaufgaben", level: "Fortschreiter", viewContext: viewContext)
            } else if count == 30 {
                setAchievement(name: "30 Hausaufgaben", level: "Profi", viewContext: viewContext)
            }
            
        } else if type == AchievementsType.finishHomeWorks {
            if count == 7 {
                setAchievement(name: "7 Hausaufgaben fertig", level: "Einsteiger", viewContext: viewContext)
            }
            
        } else if type == AchievementsType.subjects {
            if count == 10 {
                setAchievement(name: "10 Fächer", level: "Grundschüler", viewContext: viewContext)
            } else if count == 14 {
                setAchievement(name: "14 Fächer", level: "Gymniasast", viewContext: viewContext)
            }
        }
        
    }
    
    /// Add the Achievements into the CoreData
    /// - Parameters:
    ///   - name: of the Achievement
    ///   - level: of the Achievement
    ///   - viewContext: to save the CoreData
    private func setAchievement(name: String, level: String, viewContext: NSManagedObjectContext) {
        let newAchievements = AchievementsData(context: viewContext)
        newAchievements.name = name
        newAchievements.level = level
        
        saveContext(viewContext: viewContext)
    }
}
