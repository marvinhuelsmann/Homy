//
//  AddTimeTableView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 23.03.21.
//

import SwiftUI
import Combine

struct AddTimeTableView: View {
    
    var weekDay: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    /// current color sheme
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(
        entity: SubjectsData.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
        /// get all subjects
    )private var subjects: FetchedResults<SubjectsData>
    
    @FetchRequest(
        sortDescriptors: []
        /// get all timetables
    )private var timeTable: FetchedResults<TimeTableData>
    
    /// feeback generator
    private let generator = UISelectionFeedbackGenerator()
    
    /// form inpts
    @State private var subject: String? = ""
    @State private var hour: String = ""
    
    /// if the form is fill in
    @State private var fillInAll: Bool = true
    
    var body: some View {
        
        Form {
            Section(header: Text("Fach*"), footer: Text("Setzte dein Fach in die gewählte Stunde. Um dein Stundenplan zu vervollständigen und von Homy einen Rucksack Planer angezeigt zu bekommen.")) {
                
                Picker(selection: $subject, label: Text("Fach")) {

                    ForEach(subjects) { subjectObject in
                        Text(subjectObject.name ?? "")
                            .tag(subjectObject.name as String?)
                    }
                }
                
                TextField("In der 3. Stunde", text: $hour)
                    .keyboardType(.numberPad)
                    .onReceive(Just(hour)) { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered != newValue {
                            self.hour = filtered
                        }
                    }
            }
            
            Section {
                HStack(alignment: .center) {
                    Spacer()
                    Button("Stunde am \(weekDay) hinzufügen") {
                        if subject != "" && hour != "" {
                            makeTimeTableSubject()
                        } else {
                            fillInAll = false
                        }
                        generator.selectionChanged()
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .listRowInsets(EdgeInsets())
                .padding()
                .background(Color.white)
                .cornerRadius(5)
                .shadow(radius: 4)
                .padding()
                
                if !fillInAll {
                    HStack {
                        Spacer()
                        Text("Es wurden nicht alle relevanten benötigten Felder ausgefüllt!")
                            .bold()
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .listRowInsets(EdgeInsets())
                }
            }
            .background(colorScheme == .light ? Color(UIColor.secondarySystemBackground) : Color.black)
            
            
        }
        .navigationTitle("Stundeplan")
    }
    
    /// Save the Context from the
    func saveContext() {
        do {
            try viewContext.save()
            self.mode.wrappedValue.dismiss()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// Add a new TimeTable Subject with the data from the form
    func makeTimeTableSubject() {
        
        
        let newTimeTableSubject = TimeTableData(context: viewContext)
        newTimeTableSubject.subject = self.subject
        newTimeTableSubject.date = self.weekDay
        newTimeTableSubject.hour = self.hour
        saveContext()
        
        //TODO: Add Achievement
        
        AchievementsHandler().setAchievements(type: AchievementsType.timeTable, count: timeTable.count, viewContext: viewContext)
    }
}

struct AddTimeTableView_Previews: PreviewProvider {
    static var previews: some View {
        AddTimeTableView(weekDay: "Montag")
    }
}
