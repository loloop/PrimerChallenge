//
//  Body.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public protocol Body {
    var additionalHeaders: [String: String] { get }
    func encode() throws -> Data
}

final class EmptyBody: Body {
    var additionalHeaders: [String: String] = [:]
    func encode() throws -> Data { Data() }
}
