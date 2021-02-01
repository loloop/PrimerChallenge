//
//  Response.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public struct Response {
    public let request: Request
    private let urlResponse: HTTPURLResponse
    public let data: Data?

    public init(request: Request, urlResponse: HTTPURLResponse, data: Data?) {
        self.request = request
        self.urlResponse = urlResponse
        self.data = data
    }
}
