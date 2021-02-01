//
//  RepositoryErrorHashable.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import ChallengeFoundation

struct RepositoryErrorHashable: Hashable {
    let id = UUID()
    let error: NetworkError

    init(error: NetworkError) {
        self.error = error
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: RepositoryErrorHashable, rhs: RepositoryErrorHashable) -> Bool {
        lhs.id == rhs.id
    }
}
