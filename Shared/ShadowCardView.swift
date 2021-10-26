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
    var backgroundColor: UIBlurEffect
    var foregroundColor: Color
    var size: Sizes
    
    var body: some View {
        NavigationLink(
            destination: destination,
            label: {
                ZStack {
                    VisualEffectView(effect: backgroundColor)
                        .blur(radius: 7)
                        .frame(width: 400, height: getSpecificSizeHeight(size: size) , alignment: .center)
                    
                    VStack {
                        Text(title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(foregroundColor)
                        
                        Text(bodyText)
                            .foregroundColor(foregroundColor)
                            .font(.callout)
                            .fontWeight(.medium)
                        
                    }
                    .padding()
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
        ShadowCardView(title: "Test", bodyText: "Lorem ipsum, text only for debug", destination: AnyView(TabItemView()), backgroundColor: UIBlurEffect(style: .dark), foregroundColor: .white, size: Sizes.large)
    }
}
