//
//  WeekDaysView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 23.03.21.
//

import SwiftUI
import CoreData

struct WeekDaysView: View {
    @State private var showAlert = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        VStack {
            
            List {
                ForEach(TimeTableType().getAllTypes(), id: \.self) { types in
                    NavigationLink(types, destination: DayDetailView(date: TimeTableTypes(rawValue: types) ?? TimeTableTypes.monday))
                }
            }
            .listStyle(PlainListStyle())
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Alle löschen") {
                            self.showAlert = true
                        }
                    }
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Bist du sicher?"),
                    message: Text("Du löscht deinen gesammten Stundenplan. Du kannst auch einzelne Stunden manuell löschen!"),
                    primaryButton: .default(
                        Text("Abbrechen")
                    ),
                    secondaryButton: .destructive(
                        Text("Löschen").bold(),
                        action: deleteAllTimeTables
                    )
                )
            }
            
        }
        .navigationTitle("Stundenplan")
    }
    
    /// Save the Context from the
    func saveContext() {
        do {
            try viewContext.save()
            mode.wrappedValue.dismiss()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// Delete all HomeWorks they saved in HomeWorkCoreData
    private func deleteAllTimeTables() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TimeTableData")
        
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                viewContext.delete(item)
            }
            
            saveContext()
            
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
}

struct WeekDaysView_Previews: PreviewProvider {
    static var previews: some View {
        WeekDaysView()
    }
}
