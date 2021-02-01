//
//  Status.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public struct Status: Hashable {
    public let rawValue: String
}

public extension Status {
    static let ok: Status = Status(rawValue: "200")
    static let notFound: Status = Status(rawValue: "404")
}
