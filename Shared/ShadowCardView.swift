//
//  ShadowCardView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 07.06.21.
//

import SwiftUI

struct ShadowCardView: View {
    var title: String
    var bodyText: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemMaterialDark))
                        .blur(radius: 10)
                        .frame(width: 400, height: 200, alignment: .center)
                    
                    VStack {
                        Text(title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text(bodyText)
                            .foregroundColor(.white)
                            .font(.callout)
                            .fontWeight(.medium)
                        
                    }
                }
                .padding()
                .cornerRadius(1)
                .shadow(radius: 5)
            })
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct ShadowCardView_Previews: PreviewProvider {
    static var previews: some View {
        ShadowCardView(title: "Test", bodyText: "Lorem ipsum, text only for debug", destination: AnyView(TabItemView()))
    }
}
