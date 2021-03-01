//
//  WorkDetailView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI

struct WorkDetailView: View {
    var homework: HomeWorkCoreData
    var body: some View {
        
        VStack {
            VStack {
                VStack {
                    Text(homework.subject ?? "Undefined")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    Text("\(checkDate()) bis \(checkTime(date: homework.timeEnd ?? Date())) (\(checkDateName(date: homework.timeEnd ?? Date())))")
                        .foregroundColor(.secondary)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                }
                
                VStack {
                    HStack {
                        Text("Aufgabe:")
                            .padding(.leading, 25)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(homework.name ?? "Undefined")
                        
                        Spacer()
                    }
                }
                .padding(.top, 50)
                
                if homework.notice != "" {
                    VStack {
                        HStack {
                            Text("Notizen:")
                                .padding(.leading, 25)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            ScrollView {
                                Text(homework.notice ?? "Undefined")
                            }
                            Spacer()
                            
                        }
                    }
                    .padding(.top, 15)
                }
                
                if homework.link != "" {
                    VStack {
                        HStack {
                            Text("Aufgaben einreichen:")
                                .padding(.leading, 25)
                                .font(.headline)
                                .foregroundColor(.primary)
                            
                            Button("Zu Abgabe") {
                                if let url = URL(string: homework.link ?? "Undefined") {
                                    UIApplication.shared.open(url)
                                }
                            }
                            .foregroundColor(.blue)
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 15)
                }
                
                Spacer()
                Spacer()
                Spacer()
                
            }
        }
    }
    
    func checkTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "UTC") // Eastern Standard Time
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func checkDateName(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("dd.MM")
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "UTC") // Eastern Standard Time
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    func checkDate() -> String {
        let calender = Calendar.current
        
        if homework.timeEnd ?? Date() < Date()  {
            if calender.isDateInToday(homework.timeEnd ?? Date()) {
                return "Heute Abgelaufen"
            } else if calender.isDateInYesterday(homework.timeEnd ?? Date()) {
                return "Gestern Abgelaufen"
            } else {
                return "Abgelaufen"
            }
        }
        
        if calender.isDateInToday(homework.timeEnd ?? Date()) {
            return "Heute fällig"
        } else if calender.isDateInTomorrow(homework.timeEnd ?? Date()) {
            return "Morgen fällig"
        } else if calender.isDateInWeekend(homework.timeEnd ?? Date()) {
            return "In dieser Woche fällig"
        } else {
            return "In einiger Zeit fällig"
        }
    }
}

//struct WorkDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        WorkDetailView()
//            .preferredColorScheme(.light)
//    }
//}
