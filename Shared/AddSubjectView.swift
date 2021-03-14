//
//  AddSubjectView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 14.03.21.
//

import SwiftUI

struct AddSubjectView: View {
    
    init() {
        if colorScheme == .dark {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [])
    private var subjects: FetchedResults<SubjectsData>
    
    private let generator = UISelectionFeedbackGenerator()
    
    @State private var name: String = ""
    @State private var fillInAll: Bool = true
    
    @ObservedObject var notificationManager = NotificationHandler()
    
    
    var body: some View {
        
        VStack {
            
            Form {
                Section(header: Text("Aufgabe*")) {
                    TextField("Arbeitsblatt 4", text: $name)
                }
     
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Hausaufgabe hinzufügen") {
                            if name != "" {
                                makeSubject()
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
                    .shadow(radius: 10)
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
        }
        .navigationTitle("Hinzufügen")
    }
    
    /// Save the Context from the
    private func saveContext() {
        do {
            try viewContext.save()
            self.mode.wrappedValue.dismiss()
        } catch {
            let error = error as NSError
            fatalError("Unresolved Error: \(error)")
        }
    }
    
    /// Add a new Subject with the data from the form
    func makeSubject() {
    
        
        let newSubject = SubjectsData(context: viewContext)
        newSubject.name = self.name
        
        saveContext()
    }
}

struct AddSubjectkView_Previews: PreviewProvider {
    static var previews: some View {
        AddSubjectView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 Pro")
    }
}
