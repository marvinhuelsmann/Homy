//
//  BioMetricType.swift
//  HomeWorkPlanner
//
//  Created by Marvin Hülsmann on 14.03.21.
//

import Foundation
import LocalAuthentication

enum BiometricType {
    case touch
    case face
    case none
}

/// Detect your device with the current name.
/// - Returns: Device Biometric name
func getBiometricTypeName() -> String {
    
    if getBiometricType() == BiometricType.face {
        return "FaceID"
    } else if getBiometricType() == BiometricType.touch {
        return "TouchID"
    } else {
        return "None"
    }
}

// Detect your device.
func getBiometricType() -> BiometricType {
    
    let authenticationContext = LAContext()
    authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    switch (authenticationContext.biometryType){
    case .faceID:
        return .face
    case .touchID:
        return .touch
    default:
        return .none
    }
}
