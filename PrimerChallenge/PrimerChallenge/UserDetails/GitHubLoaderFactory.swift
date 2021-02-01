//
//  GitHubLoaderFactory.swift
//  PrimerChallenge
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation
import ChallengeFoundation

enum GitHubLoaderFactory {

    public static func loader(edgeLoader: Loader = URLLoader()) -> Loader {
        let loader = BaseLoader()

        loader
            .chain(RequestModifyingLoader { request in
                var copy = request
                copy.host = GitHubLoaderFactory.baseURL
                return copy
            })
            .chain(edgeLoader)

        return loader
    }

    static var baseURL: String {
        #if DEBUG
        if DebugSettings.shared.isStagingEnabled {
            return "staging.api.github.com"
        }
        #endif

        return "api.github.com"
    }

    static func repositories(for user: String) -> Request {
        /// Using `users/` instead of `orgs/` lets us search for repositories in both users and organizations
        Request(path: "users/\(user)/repos")
    }

}
