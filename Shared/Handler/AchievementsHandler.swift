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
                setAchievement(name: "5 Hausaufgaben", level: "Du hast 5 Aufgaben in Homy eingetragen, Homy wartet auf mehr...", viewContext: viewContext)
            } else if count == 15 {
                setAchievement(name: "15 Hausaufgaben", level: "Du bist dabei viele Hausafgaben zu erstellen, gut!", viewContext: viewContext)
            } else if count == 30 {
                setAchievement(name: "35 Hausaufgaben", level: "Du hast 35 Hausaufgaben erstellt damit ist deine Lieblings App Homy", viewContext: viewContext)
            }
            
        } else if type == AchievementsType.finishHomeWorks {
            if count == 7 {
                setAchievement(name: "7 Hausaufgaben fertig", level: "Du hast 7 deiner Aufgaben erledigt, weiter so!", viewContext: viewContext)
            }
        } else if type == AchievementsType.subjects {
            if count == 10 {
                setAchievement(name: "10 Fächer hinzugefügt", level: "Damit bist du ein guter Grundschüler der seine Fächer mit Homy gut sortiert!", viewContext: viewContext)
            } else if count == 22 {
                setAchievement(name: "22 Fächer", level: "Du hast Homy schon oft für deine Hausaufgaben genutzt", viewContext: viewContext)
            }
            
        } else if type == AchievementsType.timeTable {
            if count == 15 {
                setAchievement(name: "15 Stunden", level: "Du hast 15 Fach Stunden hinzugefügt damit bist du jetzt in der Grundschule.", viewContext: viewContext)
            } else if count == 20 {
                setAchievement(name: "20 Stunden", level: "Mit 20 Fach Stunden bist du ein Schüler der ganz schön viel zu tuhen hat.", viewContext: viewContext)
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
