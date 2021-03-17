//
//  InformationsView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 14.03.21.
//

import SwiftUI

struct InformationsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
        
                TitleView()
                
                InformationContainerView()
                
                Spacer(minLength: 30)
                
                Button(action: {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                    
                    mode.wrappedValue.dismiss()
                }) {
                    Text("Los gehts")
                        .customButton()
                }
                .padding(.horizontal)
                
            }
            .padding(.top, 100)
           

        }
    }
}


struct InformationDetailView: View {
    var title: String = "title"
    var subTitle: String = "subTitle"
    var imageName: String = "car"
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: imageName)
                .font(.largeTitle)
                .foregroundColor(.mainColor)
                .padding()
                .accessibility(hidden: true)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibility(addTraits: .isHeader)
                
                Text(subTitle)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.top)
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            Text("Willkommen bei")
                .customTitleText()
            
            Text("Homy")
                .customTitleText()
                .foregroundColor(.mainColor)
        }
    }
}

struct ButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.mainColor))
            .padding(.bottom)
    }
}

extension View {
    func customButton() -> ModifiedContent<Self, ButtonModifier> {
        return modifier(ButtonModifier())
    }
}

extension Text {
    func customTitleText() -> Text {
        self
            .fontWeight(.black)
            .font(.system(size: 36))
    }
}

extension Color {
    static var mainColor = Color(UIColor.systemIndigo)
}

struct InformationContainerView: View {
    var body: some View {
        VStack(alignment: .leading) {
            InformationDetailView(title: "Aufgaben", subTitle: "Mit Homy ist deine Aufgaben Verwaltung und deine Erinnerungen kinderleicht zu bedienen.", imageName: "list.bullet.rectangle")
            
            InformationDetailView(title: "Benachrichtigungen", subTitle: "Wenn du willst erinnert dich Homy dann vorher wenn du deine Aufgaben abgeben musst.", imageName: "bell")
            
            InformationDetailView(title: "Privat", subTitle: "Homy teilt keine Daten in Clouds. Sie bleiben einzig und alleine auf deinem Gerät gespeichert.", imageName: "lock")
        }
        .padding(.horizontal)
    }
}

struct InformationsView_Previews: PreviewProvider {
    static var previews: some View {
        InformationsView()
    }
}
