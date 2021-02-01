//
//  GitHubRepository.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

struct GitHubRepository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let owner: GitHubRepositoryOwner
    let htmlUrl: URL
}

extension GitHubRepository: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: GitHubRepository, rhs: GitHubRepository) -> Bool {
        lhs.id == rhs.id
    }
}


