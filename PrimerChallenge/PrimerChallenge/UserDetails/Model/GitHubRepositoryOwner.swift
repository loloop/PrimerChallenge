//
//  GitHubRepositoryOwner.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

struct GitHubRepositoryOwner: Codable, Identifiable {
    let id: Int
    let login: String
    let avatarURL: URL
}
