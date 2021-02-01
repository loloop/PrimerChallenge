//
//  BaseLoader.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

open class BaseLoader: Loader {

    public init() {}

    public var nextLoader: Loader? {
        willSet {
            assert(nextLoader == nil, "nextLoader should only be set once by \(self)")
        }
    }

    @discardableResult
    open func chain(_ loader: Loader) -> Loader {
        if nextLoader != nil {
            nextLoader?.chain(loader)
        } else {
            nextLoader = loader
        }
        return self
    }

    open func load(request: Request, completion: @escaping ((Result<Response, NetworkError>) -> Void)) {
        nextLoader?.load(request: request, completion: completion)
    }
}
