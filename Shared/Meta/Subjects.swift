//
//  Subjects.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import Foundation


enum Subjects: String, CaseIterable {
    case GERMAN = "Deutsch"
    case ENGLISH = "Englisch"
    case MATH = "Mathe"
    case PHYSIK = "Physik"
    case LATAIN = "Latain"
    case BIOLOGIE = "Biologie"
    case RELIGION = "Religionslehre"
    case INFORMATIK = "Informatik"
    case CHEMIE = "Chemie"
    case SOCIAL = "Sozial"
    case HOMEBUSINESS = "Hauswirtschaft"
    case FRANCE = "Französich"
    case SPANISH = "Spanisch"
    case HISTORY = "Geschichte"
    

}

func getSubjectname(sub: Subjects) -> String {
    return sub.rawValue
}

func getSubject(sub: String) -> Subjects {
    for type in Subjects.allCases {
        if getSubjectname(sub: type) == sub {
            return type
        }
    }
    return Subjects.GERMAN
}
