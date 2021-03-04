//
//  ContentView.swift
//  Shared
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI
import CoreData

struct WorkListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \HomeWorkCoreData.timeEnd, ascending: true) ])
    /// List of all current HomeWorks in HomeWorksCoreData
    private var homeworks: FetchedResults<HomeWorkCoreData>
    
    /// Editing Mode to delete HomeWorks
    @State private var isEditing: Bool = false
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    if self.homeworks.isEmpty {
                        Text("Keine Hausaufgaben eingetragen!")
                    }
                    
                    ForEach(homeworks) { homework in
                        Section(header: Text(getSubjectname(sub: getSubject(sub: homework.subject ?? "Undefined")))) {
                            HomeWorkDetail(homework: homework)
                        }
                    }
                    .onDelete(perform: deleteHomeWork(offsets:))
                }
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                .listStyle(PlainListStyle())
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !isEditing {
                            NavigationLink(
                                destination: AddHomeWorkView(),
                                label: {
                                    VStack {
                                        Text("Hinzufügen")
                                        
                                    }
                                })
                        } else {
                            
                            Button("Alle löschen") {
                                self.showAlert = true
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !self.homeworks.isEmpty {
                            VStack {
                                Button(isEditing ? "Fertig" : "Bearbeiten") {
                                    self.isEditing.toggle()
                                }
                            }
                        }
                    }
                })
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Bist du sicher?"),
                        message: Text("Du löscht alle deine gespeicherten Hausaufgaben. Du kannst diesen Schritt nicht mehr rückgänging machen!"),
                        primaryButton: .default(
                            Text("Abbrechen")
                        ),
                        secondaryButton: .destructive(
                            Text("Löschen"),
                            action: deleteAllHomeWorks
                        )
                    )
                }
                
                .navigationTitle("Hausaufgaben")
            }
            
            Spacer()
        }
    }
    
    /// Delete all HomeWorks they saved in HomeWorkCoreData
    private func deleteAllHomeWorks() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HomeWorkCoreData")
        
        // Configure Fetch Request
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                viewContext.delete(item)
            }
            
            // Save Changes
            saveContext()
            self.isEditing = false
            
        } catch {
            // Error handling
        }
    }
    
    /// Saves he
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// To delete one HomeWork
    /// - Parameter offsets: To get the current HomeWork
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

/// The detail view of one HomeWork in the list
struct HomeWorkDetail: View {
    var homework: HomeWorkCoreData
    var body: some View {
        NavigationLink(destination: WorkDetailView(homework: homework)) {
            
            VStack(alignment: .leading) {
                Text(homework.name ?? "Undefined")
                
                Text("Bis \(checkTime(date: homework.timeEnd ?? Date())) (\(checkDateEnd()))")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    /// To get the current Hour and Minutes of the Date
    /// - Parameter date: The date that will be converted
    /// - Returns: The converted Date in HH:MM
    func checkTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "nl_NL")
        formatter.setLocalizedDateFormatFromTemplate("HH:mm")
        formatter.timeZone = TimeZone(abbreviation: TimeZone.current.abbreviation() ?? "UTC") // Eastern Standard Time
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    /// To get the end Date
    /// - Returns: The name of the day
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


