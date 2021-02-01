//
//  RequestModifyingLoader.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public class RequestModifyingLoader: BaseLoader {

    private let modifier: (Request) -> Request

    public init(_ modifier: @escaping (Request) -> Request) {
        self.modifier = modifier
    }

    public override func load(request: Request, completion: @escaping ((Result<Response, NetworkError>) -> Void)) {
        let modifiedRequest = modifier(request)
        super.load(request: modifiedRequest, completion: completion)
    }

}
