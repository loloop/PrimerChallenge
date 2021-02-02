//
//  ChallengeBundle.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

private final class _StubForBundle {}

extension Bundle {
    static let challenge: Bundle = Bundle(for: _StubForBundle.self)
}
