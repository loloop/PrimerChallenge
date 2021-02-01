//
//  Method.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public struct Method: Hashable {
    public let rawValue: String
}

public extension Method {
    static let get = Method(rawValue: "GET")
    static let post = Method(rawValue: "POST")
}
