//
//  TimeTableHandler.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 23.03.21.
//

import SwiftUI

struct TimeTableHandler {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    private var timeTable: FetchedResults<TimeTableData>
    
    private func dayNumberOfWeek() -> Int? {
        let index = Calendar.current.component(.weekday, from: Date()) // this returns an Int
        return index - 1
    }
    
    func getCurrentWeekDayName(forNextDay: Bool) -> String {
        if dayNumberOfWeek() == 1 {
            return forNextDay ? TimeTableTypes.tuesday.rawValue : TimeTableTypes.monday.rawValue
        } else if dayNumberOfWeek() == 2 {
            return forNextDay ? TimeTableTypes.wednesday.rawValue : TimeTableTypes.tuesday.rawValue
        } else if dayNumberOfWeek() == 3 {
            return forNextDay ? TimeTableTypes.thursday.rawValue : TimeTableTypes.wednesday.rawValue
        } else if dayNumberOfWeek() == 4 {
            return forNextDay ? TimeTableTypes.friday.rawValue : TimeTableTypes.thursday.rawValue
        } else if dayNumberOfWeek() == 5 {
            return forNextDay ? TimeTableTypes.monday.rawValue : TimeTableTypes.friday.rawValue
        } else {
            return forNextDay ? TimeTableTypes.monday.rawValue : TimeTableTypes.weekday.rawValue
        }
    }
    
    func getSubjects(array: FetchedResults<TimeTableData> ,forNextDay: Bool) -> Array<String> {
        var subjects =  Array<String>()
        let weekDay: String = getCurrentWeekDayName(forNextDay: forNextDay)

        
        for result in array {
            if result.date == weekDay {
                subjects.append(result.subject!)
            }
        }
        
        return subjects
    }
    
    func getSubjectsOnDay(array: FetchedResults<TimeTableData> ,forDay: TimeTableTypes) -> Array<TimeTableData> {
        var subjects =  Array<TimeTableData>()

        
        for result in array {
            if result.date == forDay.rawValue {
                subjects.append(result)
            }
        }
        
        return subjects
    }
    
    func getChangeSubjectsForNextDayIn(results: FetchedResults<TimeTableData>) -> Array<String> {
        let todaySubjects: Array<String> = getSubjects(array: results, forNextDay: false)
        let nextDaySubjects: Array<String> = getSubjects(array: results, forNextDay: true)
        
        var changeableSubjects: Array<String> = []
        
        for nextDay in nextDaySubjects {
            if !todaySubjects.contains(nextDay) {
                changeableSubjects.append(nextDay)
            }
        }
    
        return changeableSubjects
    }
    
    func getChangeSubjectsForNextDayOut(results: FetchedResults<TimeTableData>) -> Array<String> {
        let todaySubjects: Array<String> = getSubjects(array: results, forNextDay: false)
        let nextDaySubjects: Array<String> = getSubjects(array: results, forNextDay: true)
        
        var changeableSubjects: Array<String> = []
        
        for today in todaySubjects {
            if !nextDaySubjects.contains(today) {
                changeableSubjects.append(today)
            }
        }
    
        return changeableSubjects
    }
}
