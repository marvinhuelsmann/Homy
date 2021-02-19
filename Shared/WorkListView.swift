//
//  ContentView.swift
//  Shared
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI

struct WorkListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \HomeWorkCoreData.timeEnd, ascending: true) ])
    private var homeworks: FetchedResults<HomeWorkCoreData>
    
    @State private var isEditing = false
    
    var body: some View {
        
        NavigationView {
            List {
                if self.homeworks.isEmpty {
                    Text("Keine Hausaufgaben eingetragen!")
                }
                
                ForEach(homeworks) { homework in
                    HomeWorkDetail(homework: homework)
                }
                .onDelete(perform: deleteHomeWork(offsets:))
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
            .toolbar(content: {
                
                HStack {
                    #if os(iOS)
                    Button(action: {
                        self.isEditing.toggle()
                    }) {
                        Text(isEditing ? "Fertig" : "Edit")
                            .frame(width: 50, height: 40)
                    }
                    #endif
                    
                    NavigationLink(
                        destination: AddHomeWorkView(),
                        label: {
                            VStack {
                                Text("Hinzufügen")
                                    .foregroundColor(.blue)
                                    .font(.headline)
                                
                            }
                        })
                }
            })
            
            .navigationTitle("Hausaufgaben")
            
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    func deleteHomeWork(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                homeworks[$0]
            }.forEach(viewContext.delete)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            saveContext()
        }
    }
}

struct WorkListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkListView()
            .previewDevice("iPhone 12 Pro")
    }
}

struct HomeWorkDetail: View {
    var homework: HomeWorkCoreData
    var body: some View {
        NavigationLink(destination: WorkDetailView(homework: homework)) {
            
            VStack(alignment: .leading) {
                Text(homework.name ?? "Undefined")
            
                Text("\(getSubjectname(sub: getSubject(sub: homework.subject ?? "Undefined"))) bis \(checkTime(date: homework.timeEnd ?? Date())) (\(checkDateEnd()))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
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

    
    func checkDateEnd() -> String {
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
            return "Heute"
        } else if calender.isDateInTomorrow(homework.timeEnd ?? Date()) {
            return "Morgen"
        } else if calender.isDateInWeekend(homework.timeEnd ?? Date()) {
            return "In dieser Woche"
        } else {
            return "Bald"
        }
    }
}
