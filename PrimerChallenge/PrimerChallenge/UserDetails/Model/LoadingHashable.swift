//
//  File.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

struct LoadingHashable: Hashable {
    let id = UUID()

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: LoadingHashable, rhs: LoadingHashable) -> Bool {
        lhs.id == rhs.id
    }
}
