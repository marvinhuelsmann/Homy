//
//  AddHomeWorkView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI


struct AddHomeWorkView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var movies: FetchedResults<HomeWorkCoreData>
    
    private let generator = UISelectionFeedbackGenerator()
    
    @State private var name: String = ""
    @State private var timeEnd = Date().addingTimeInterval(1200)
    @State private var subject: String = ""
    @State private var link: String = ""
    
    @State private var notice: String = ""
    @State private var fillInAll: Bool = true
    
    @ObservedObject var notificationManager = NotificationHandler()
    
    private var choose = [Subjects.ENGLISH.rawValue, Subjects.GERMAN.rawValue, Subjects.MATH.rawValue, Subjects.PHYSIK.rawValue, Subjects.BIOLOGIE.rawValue, Subjects.LATAIN.rawValue, Subjects.RELIGION.rawValue, Subjects.SPANISH.rawValue, Subjects.HOMEBUSINESS.rawValue, Subjects.FRANCE.rawValue, Subjects.INFORMATIK.rawValue, Subjects.CHEMIE.rawValue, Subjects.HISTORY.rawValue, Subjects.SOCIAL.rawValue, Subjects.CREATE.rawValue, Subjects.GEOGRAPHIE.rawValue]
    
    var body: some View {
        
        VStack {
            
            Form {
                Section(header: Text("Aufgabe*")) {
                    TextField("Arbeitsblatt 4", text: $name)
                    
                    Picker(selection: $subject, label: Text("Fach")) {
                        ForEach(choose, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section(header: Text("Link")) {
                    TextField("Schulwebsite Link", text: $link)
                }
                
                Section(header: Text("Notiz")) {
                    TextEditor(text: $notice)
                }
                
                Section(header: Text("Zeit*")) {
                    DatePicker("Bis wann?", selection: $timeEnd)
                }
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Hausaufgabe hinzufügen") {
                            if name != "" && subject != "" {
                                makeHomeWork()
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
                .background(Color(UIColor.black))
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
    
    /// Add a new HomeWork with the data from the form
    func makeHomeWork() {
        
        if SettingsView().allowNotifications {
            let minute: TimeInterval = -4
            
            self.notificationManager.sendNotification(title: self.name, subtitle: self.subject, body: self.notice, launchIn: self.timeEnd.addingTimeInterval(minute))
        }
        
        let newHomeWork = HomeWorkCoreData(context: viewContext)
        newHomeWork.name = self.name
        newHomeWork.subject = getSubjectname(sub: getSubject(sub: self.subject))
        newHomeWork.notice = self.notice
        
        newHomeWork.timeEnd = self.timeEnd
        newHomeWork.link  = self.link
        
        saveContext()
    }
}

struct AddHomeWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeWorkView()
            .previewDevice("iPhone 12 Pro")
    }
}
