//
//  SubjectListView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 14.03.21.
//

import SwiftUI

import CoreData

struct SubjectListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [])
    /// List of all current HomeWorks in HomeWorksCoreData
    private var subjects: FetchedResults<SubjectsData>
    
    /// Check if the AddHomeWorkView is open
    @State private var isAddButtonClicking: Bool = false
    
    /// Editing Mode to delete HomeWorks
    @State private var isEditing: Bool = false
    @State private var showAlert = false
    
    var body: some View {
            VStack {
                List {
                    if self.subjects.isEmpty {
                        Text("Keine Fächer eingetragen!")
                    }
                    
                    ForEach(subjects) { subject in
                        VStack {
                            Text(subject.name ?? "Undefined")
                        }
                    }
                    .onDelete(perform: deleteSubjects(offsets:))
                }
                .environment(\.editMode, .constant(self.isEditing ? EditMode.active : EditMode.inactive)).animation(Animation.spring())
                .listStyle(PlainListStyle())
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if !isEditing {
                            NavigationLink(destination: AddSubjectView(), isActive: $isAddButtonClicking, label: {
                                VStack {
                                    Text("Neues Fach")
                                }
                            })
            
                        } else {
                            Button("Alle löschen") {
                                self.showAlert = true
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        if !self.subjects.isEmpty {
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
                            action: deleteAllSubjects
                        )
                    )
                }
                
                .navigationTitle("Fächer")
            } .onAppear {
                    self.isAddButtonClicking = false

            }
            
            Spacer()
    }
    
    /// Delete all HomeWorks they saved in HomeWorkCoreData
    private func deleteAllSubjects() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SubjectsData")
        
        fetchRequest.includesPropertyValues = false
        
        do {
            let items = try viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                viewContext.delete(item)
            }
    
            saveContext()
            self.isEditing = false
            
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// Saves the HomeWorks
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
    func deleteSubjects(offsets: IndexSet) {
        withAnimation {
            offsets.map {
                subjects[$0]
            }.forEach(viewContext.delete)
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
            saveContext()
        }
    }
}

struct SubjectListView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectListView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 Pro")
    }
}
