//
//  AddHomeWorkView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 13.01.21.
//

import SwiftUI
import Combine

struct AddHomeWorkView: View {
    
    init() {
        if colorScheme == .dark {
            UITableView.appearance().backgroundColor = .clear
        }
    }
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme
    
    @FetchRequest(sortDescriptors: [])
    private var homeworks: FetchedResults<HomeWorkCoreData>
    
    @FetchRequest(
        entity: SubjectsData.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]
    )private var subjects: FetchedResults<SubjectsData>
    
    
    private let generator = UISelectionFeedbackGenerator()
    
    @State private var name: String = ""
    @State private var timeEnd = Date().addingTimeInterval(1200)
    @State private var subject: String? = ""
    @State private var link: String = ""
    @State private var notify: String = ""
    
    @State private var notice: String = ""
    @State private var fillInAll: Bool = true
    
    @ObservedObject var notificationManager = NotificationHandler()
    
    var body: some View {
        
        VStack {
            Form {
                Section(header: Text("Aufgabe*")) {
                    TextField("Arbeitsblatt 4", text: $name)
                    
                    Picker(selection: $subject, label: Text("Fach")) {
                        
                        ForEach(subjects) { subjectObject in
                            Text(subjectObject.name ?? "")
                                .tag(subjectObject.name as String?)
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
                
                
                if SettingsView().allowNotifications {
                    Section(header: Text("Benachrichigung*")) {
                        TextField("5", text: $notify)
                            .keyboardType(.numberPad)
                            .onReceive(Just(notify)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.notify = filtered
                                }
                            }
                    }
                }
                
                Section {
                    HStack(alignment: .center) {
                        Spacer()
                        Button("Hausaufgabe hinzufügen") {
                            if name != "" && subject != "" && notify != "" {
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
        }
        .navigationTitle("Neue Aufgabe")
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
            let notifyInt: Int = Int(notify) ?? 1
            let finalSeconds: Int = notifyInt * 60
            
            let minute: TimeInterval = TimeInterval(-finalSeconds)
            
            self.notificationManager.sendNotification(title: self.name, subtitle: self.subject, body: self.notice, launchIn: self.timeEnd.addingTimeInterval(minute))
        }
        
        let newHomeWork = HomeWorkCoreData(context: viewContext)
        newHomeWork.name = self.name
        newHomeWork.subject = self.subject
        newHomeWork.notice = self.notice
        
        newHomeWork.timeEnd = self.timeEnd
        newHomeWork.link  = self.link
        newHomeWork.notify = self.notify
        
        saveContext()
    }
}

struct AddHomeWorkView_Previews: PreviewProvider {
    static var previews: some View {
        AddHomeWorkView()
            .preferredColorScheme(.light)
            .previewDevice("iPhone 12 Pro")
    }
}
