//
//  NetworkError.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public struct NetworkError: Error {

    public let message: String

    public init(_ message: String = "") {
        self.message = message
    }
}
