//
//  AchievementTypes.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 21.03.21.
//

import SwiftUI

enum AchievementsType: String, CaseIterable {
    case homeWorkList = "Hausaufgaben"
    case finishHomeWorks = "Fertige Aufgaben"
    case subjects = "Fächer"
    case timeTable = "Stunden Plan"
}

/// Get the Achievement Type color for the cards
/// - Parameter type: to get the achievement color
/// - Returns: the achievement color
func getColorOfAchievementType(type: String) -> UIColor {
    if type == AchievementsType.homeWorkList.rawValue {
        return UIColor.red
    } else if type == AchievementsType.finishHomeWorks.rawValue {
        return UIColor.orange
    } else if type == AchievementsType.subjects.rawValue {
        return UIColor.green
    } else if type == AchievementsType.timeTable.rawValue {
        return UIColor.purple
    }
    
    return UIColor.magenta
}
