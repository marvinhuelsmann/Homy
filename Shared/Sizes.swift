//
//  Sizes.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 08.06.21.
//
import Foundation
import SwiftUI

enum Sizes: CaseIterable {
    case small
    case medium
    case large
}

func getSpecificSizeHeight(size: Sizes) -> CGFloat {
    return CGFloat(Sizes.large == size ? 200 : Sizes.medium == size ? 150 : Sizes.small == size ? 100 : 75)
}
