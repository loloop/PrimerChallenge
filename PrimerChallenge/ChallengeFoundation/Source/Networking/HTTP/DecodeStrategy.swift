//
//  DecodeStrategy.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public struct DecodeStrategy {
    public var dataDecodingStrategy: JSONDecoder.DataDecodingStrategy?
    public var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy?
    public var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy?

    public init(dataDecodingStrategy: JSONDecoder.DataDecodingStrategy? = nil,
                dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? = nil,
                keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? = nil) {
        self.dataDecodingStrategy = dataDecodingStrategy
        self.dateDecodingStrategy = dateDecodingStrategy
        self.keyDecodingStrategy = keyDecodingStrategy
    }

    public var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        if let dataDecodingStrategy = dataDecodingStrategy {
            decoder.dataDecodingStrategy = dataDecodingStrategy
        }
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        if let keyDecodingStrategy = keyDecodingStrategy {
            decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        return decoder
    }
}
