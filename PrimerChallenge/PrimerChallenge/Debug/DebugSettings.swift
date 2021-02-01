//
//  DebugSettings.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import ChallengeFoundation

#if DEBUG
final class DebugSettings {

    static let shared = DebugSettings()

    @UserDefaultsWrapper(key: #function, defaultValue: false) var isStagingEnabled: Bool


}
#endif
