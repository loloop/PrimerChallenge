//
//  GitHubService.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import ChallengeFoundation

final class GitHubService {

    private let loader: Loader

    init(loader: Loader = GitHubLoaderFactory.loader()) {
        self.loader = loader
    }

    func repositories(for owner: GitHubRepositoryOwner,
                      page: Int,
                      completion: @escaping (Result<[GitHubRepository], NetworkError>) -> Void ) {
        repositories(for: owner.login, page: page, completion: completion)
    }

    func repositories(for user: String,
                      page: Int,
                      completion: @escaping (Result<[GitHubRepository], NetworkError>) -> Void) {
        let request = GitHubLoaderFactory.repositories(for: user, page: page)
        loader.load(request: request) { result in
            switch result {
            case .success(let response):
                guard let data = response.data else {
                    completion(.failure(NetworkError("Data not found")))
                    return
                }
                do {
                    let repositories = try request.decodeStrategy.decoder.decode([GitHubRepository].self, from: data)
                    completion(.success(repositories))
                } catch {
                    completion(.failure(NetworkError("Response failed to decode")))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
