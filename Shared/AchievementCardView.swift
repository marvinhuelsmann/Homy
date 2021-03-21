//
//  AchievementCarf.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 21.03.21.
//

import SwiftUI

struct AchievementCardView: View {
    var color: Color
    var headLine: String
    var bodyText: String
    
    var body: some View {
      
                VStack {
                    Text(headLine)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    
                    
                    Text(bodyText)
                        .foregroundColor(.white)
                        .font(.body)
                }
                .padding()
                .background(color)
                .cornerRadius(10)
                .shadow(radius: 5)
        
    }
}

struct AchievementsCardView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCardView(color: Color.white, headLine: "HeadLine", bodyText: "This is an body text")
    }
}
