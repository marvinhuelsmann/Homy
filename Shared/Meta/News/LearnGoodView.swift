//
//  LearnGoodView.swift
//  HomeWorkPlanner (iOS)
//
//  Created by Marvin Hülsmann on 20.02.21.
//

import SwiftUI

struct LearnGoodView: View {
    var body: some View {

        LongTextView(title: "Bessser lernen", upNote: "Um diesen Text zu lesen brauchst du 15 Minuten.", longText: """
                
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum interdum ligula sed est dignissim aliquam. Proin rutrum libero nibh, nec faucibus eros cursus in. Cras nulla neque, consequat eu quam sit amet, semper congue quam. Mauris gravida vitae massa ut lobortis. Nunc eu commodo libero. Vivamus venenatis interdum nisl id venenatis. Aliquam scelerisque, lorem id accumsan sodales, lectus turpis finibus orci, at scelerisque odio mauris in elit. Aenean dolor velit, rutrum et erat at, facilisis iaculis purus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Curabitur feugiat sem vitae sollicitudin tristique. Morbi condimentum est ultricies sapien porttitor faucibus. Proin egestas odio a aliquam egestas.

                Pellentesque vel pharetra dolor. Sed ut tristique massa, vitae faucibus diam. Sed interdum accumsan ligula in posuere. Curabitur eleifend auctor semper. Duis non suscipit erat. Sed a ultrices turpis. Morbi venenatis mi vel purus consectetur venenatis.

                Vivamus volutpat porta pellentesque. Morbi tempor magna dui, ac sodales nulla placerat id. Phasellus quam ex, pulvinar ac ultrices commodo, volutpat sit amet dui. Suspendisse sit amet tempus leo. Sed porttitor nisi purus. Etiam lectus metus, interdum non aliquam ac, sodales quis magna. Praesent enim lacus, dignissim at ero

                """)

    }
}

struct LearnGoodView_Previews: PreviewProvider {
    static var previews: some View {
        LearnGoodView()
    }
}
