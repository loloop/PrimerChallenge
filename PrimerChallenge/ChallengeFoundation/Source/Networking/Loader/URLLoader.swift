//
//  URLLoader.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public class URLLoader: BaseLoader {

    let session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    public override func load(request: Request, completion: @escaping ((Result<Response, NetworkError>) -> Void)) {
        guard let urlRequest = request.asURLRequest() else {
            completion(.failure(NetworkError("Cannot convert `Request` as `URLRequest`")))
            return
        }

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(
                        .failure(
                            NetworkError(error?.localizedDescription ?? "Response cannot be cast to HTTPURLResponse")
                        )
                    )
                }
                return
            }

            DispatchQueue.main.async {
                completion(
                    .success(
                        Response(request: request, urlResponse: response, data: data)
                    )
                )
            }
        }

        task.resume()
    }
}
