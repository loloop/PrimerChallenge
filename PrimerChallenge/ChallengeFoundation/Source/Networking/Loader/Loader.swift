//
//  Loader.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public protocol Loader: AnyObject {
    var nextLoader: Loader? { get set }
    @discardableResult func chain(_ loader: Loader) -> Loader
    func load(request: Request, completion: @escaping ((Result<Response, NetworkError>) -> Void))
}
