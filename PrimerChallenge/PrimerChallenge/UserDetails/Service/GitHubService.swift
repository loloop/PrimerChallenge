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

    func repositories(for user: String,
                      page: Int,
                      completion: @escaping ((result: Result<[GitHubRepository], NetworkError>, isLastPage: Bool)) -> Void) {
        let request = GitHubLoaderFactory.repositories(for: user, page: page)
        loader.load(request: request) { [weak self] result in
            guard let self = self else {
                completion((
                    result: .failure(NetworkError()),
                    isLastPage: true
                ))
                return
            }

            switch result {
            case .success(let response):

                let isLastPage = self.isLastPage(page: page, response: response)

                guard let data = response.data else {
                    completion((
                        result: .failure(NetworkError("Data not found")),
                        isLastPage: isLastPage
                    ))
                    return
                }

                let decoder = request.decodeStrategy.decoder
                do {
                    let repositories = try decoder.decode([GitHubRepository].self, from: data)
                    completion((result: .success(repositories), isLastPage: isLastPage))
                } catch {
                    let gitHubPrettyError = try? decoder.decode(GitHubError.self, from: data)
                    if let error = gitHubPrettyError {
                        completion((result: .failure(NetworkError(error.message)), isLastPage: isLastPage))
                    } else {
                        completion((result: .failure(NetworkError("Response failed to decode")), isLastPage: isLastPage))
                    }
                }
            case .failure(let error):
                completion((result: .failure(error), isLastPage: true))
            }
        }
    }

    func isLastPage(page: Int, response: Response) -> Bool {
        guard
            let linkHeader = response.urlResponse.allHeaderFields["Link"] as? String,
            let regexMatcher = try? NSRegularExpression(pattern: #"<([^>]+)>;\s+rel="last""#)
        else { return true }

        let nsRange = NSRange(location: 0, length: linkHeader.utf8.count)

        guard
            let relativeMatched = regexMatcher.firstMatch(in: linkHeader, range: nsRange),
            let range = Range(relativeMatched.range, in: linkHeader) else { return true }

        let substring = String(linkHeader[range])
            .replacingOccurrences(of: "<", with: "")
            .replacingOccurrences(of: ">; rel=\"last\"", with: "")

        let pageNumber = URLComponents(string: substring)?.queryItems?.first(where: { $0.name == "page" })?.value

        guard
            let stringNumber = pageNumber,
            let lastPageNumber = Int(stringNumber) else { return true }

        return lastPageNumber == page
    }

}
