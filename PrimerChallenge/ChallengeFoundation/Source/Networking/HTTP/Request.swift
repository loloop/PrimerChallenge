//
//  Request.swift
//  ChallengeFoundation
//
//  Created by Mauricio Cardozo on 2/1/21.
//

import Foundation

public protocol RequestOption {
    associatedtype Value
    static var defaultValue: Value { get }
}

public struct Request {

    private var components: URLComponents
    public var method: Method
    public var body: Body?
    public var headers: [String: String]
    public var decodeStrategy: DecodeStrategy

    public init(path: String = "",
                host: String = "",
                scheme: String = "https",
                method: Method = .get,
                body: Body? = nil,
                headers: [String: String] = [:],
                query: [URLQueryItem]? = nil,
                strategy: DecodeStrategy = DecodeStrategy()) {
        var comps = URLComponents()
        comps.host = host
        comps.scheme = scheme
        comps.queryItems = query
        self.method = method
        self.body = body
        self.headers = headers
        self.components = comps
        self.decodeStrategy = strategy
        self.path = path
    }

    public var query: [URLQueryItem]? {
        get {
            components.queryItems
        }
        set {
            components.queryItems = newValue
        }
    }

    public var url: URL? {
        components.url
    }

    public var host: String {
        get {
            components.host ?? ""
        }
        set {
            components.host = newValue
        }
    }

    public var path: String {
        get {
            components.path
        }
        set {
            var value = newValue
            if !newValue.hasPrefix("/") {
                value = "/" + newValue
            }
            components.path = value
        }
    }

    public var scheme: String {
        get {
            components.scheme ?? ""
        }
        set {
            components.scheme = newValue
        }
    }

}

public extension Request {
    func asURLRequest() -> URLRequest? {
        guard let url = url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        headers.forEach({ urlRequest.addValue($1, forHTTPHeaderField: $0)})
        if let body = body {
            body.additionalHeaders.forEach({urlRequest.addValue($1, forHTTPHeaderField: $0)})
            do {
                urlRequest.httpBody = try body.encode()
            } catch {
                return urlRequest
            }
        }
        return urlRequest
    }
}
