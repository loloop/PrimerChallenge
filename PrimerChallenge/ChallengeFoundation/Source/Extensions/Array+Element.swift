//
//  Array+Element.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

extension Array {
    public func element(at index: Int) -> Element? {
        guard index >= 0 && count > index else { return nil }
        return self[index]
    }
}
