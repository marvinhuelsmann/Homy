//
//  TimeTableTypes.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 23.03.21.
//

enum TimeTableTypes: String, CaseIterable {
    case monday = "Montag"
    case tuesday = "Dienstag"
    case wednesday = "Mitwoch"
    case thursday = "Donnerstag"
    case friday = "Freitag"
    case weekday = "Wochenende"
}

struct TimeTableType {
    func getAllTypes() -> Array<String> {
        return [TimeTableTypes.monday.rawValue, TimeTableTypes.tuesday.rawValue,
                TimeTableTypes.wednesday.rawValue, TimeTableTypes.thursday.rawValue,
                TimeTableTypes.friday.rawValue]
    }
}

