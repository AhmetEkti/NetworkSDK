//
//  RequestBuilder.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class RequestBuilder {
    private var endpoint: String
    private var method: HTTPMethod = .get
    private var headers: [String: String] = [:]
    private var queryItems: [URLQueryItem] = []
    private var body: Data?
    
    public init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    public func setMethod(_ method: HTTPMethod) -> RequestBuilder {
        self.method = method
        return self
    }
    
    public func addHeader(key: String, value: String) -> RequestBuilder {
        headers[key] = value
        return self
    }
    
    public func addQueryItem(name: String, value: String) -> RequestBuilder {
        queryItems.append(URLQueryItem(name: name, value: value))
        return self
    }
    
    public func setBody<T: Encodable>(_ body: T) throws -> RequestBuilder {
        self.body = try JSONEncoder().encode(body)
        return self
    }
    
    public func build() -> Endpoint {
        return Endpoint(
            path: endpoint,
            method: method,
            headers: headers,
            queryItems: queryItems.isEmpty ? nil : queryItems,
            body: body
        )
    }
}
