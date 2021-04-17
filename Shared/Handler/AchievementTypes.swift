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
func getColorOfAchievementType(type: String) -> Color {
    if type == AchievementsType.homeWorkList.rawValue {
        return Color.red
    } else if type == AchievementsType.finishHomeWorks.rawValue {
        return Color.orange
    } else if type == AchievementsType.subjects.rawValue {
        return Color.green
    } else if type == AchievementsType.timeTable.rawValue {
        return Color.purple
    } else {
        return Color.yellow
    }
}
