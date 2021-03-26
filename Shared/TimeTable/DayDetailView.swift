//
//  DayDetailView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 24.03.21.
//

import SwiftUI

struct DayDetailView: View {
    var date: TimeTableTypes
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \TimeTableData.hour, ascending: false) ])
    private var timeTable: FetchedResults<TimeTableData>
    
    @FetchRequest(sortDescriptors: [])
    private var timeTableWish: FetchedResults<TimeTableData>
    
    /// Editing Mode to delete HomeWorks
    @State private var isEditing: Bool = false
    
    var body: some View {
        VStack {
            
            List {
                ForEach(TimeTableHandler().getSubjectsOnDay(array: timeTable, forDay: date), id: \.self) { subject in
                    
                    VStack(alignment: .leading) {
                        Text(subject.subject!)
                        
                        Text("In der \(subject.hour!)ten Stunde")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
                .onDelete(perform: deleteTimeTableHour(ar:))
                
                VStack {
                    NavigationLink("Neue Stunde hinzufügen", destination: AddTimeTableView(weekDay: date.rawValue))
                }
                
            }
            .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
            .listStyle(PlainListStyle())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    VStack {
                        Button(action: {
                            self.isEditing.toggle()
                        }, label: {
                            VStack {
                                Text(isEditing ? "Fertig" : "Bearbeiten")
                                    .foregroundColor(.red)
                                    .bold()
                            }
                        })
                    }.foregroundColor(.red)
                }
            })
            
            
        }
        .navigationTitle(date.rawValue)
    }
    
    
    /// Saves the TimeTable
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// To delete one TimeTable Hour
    /// - Parameter offsets: To get the current TimeTable Hour
    func deleteTimeTableHour(ar offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let time = TimeTableHandler().getSubjectsOnDay(array: timeTable, forDay: date)[index]
                viewContext.delete(time)
            }
        }
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        saveContext()
    }
}

struct DayDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DayDetailView(date: TimeTableTypes.monday)
    }
}

