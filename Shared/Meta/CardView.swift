//
//  CardView.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI

struct CardView: View {
    var color: Color
    var headLine: String
    var bodyText: String
    var desitination: AnyView
    
    var body: some View {
            NavigationLink(
                destination: desitination,
                label: {
                    VStack {
                        Text(headLine)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text(bodyText)
                            .foregroundColor(.white)
                            .font(.body)
                    }
                    .padding()
                    .background(color)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                })

    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(color: Color.white, headLine: "HeadLine", bodyText: "This is an body text", desitination: AnyView(AddHomeWorkView()))
    }
}
