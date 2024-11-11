//
//  Endpoint.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public struct Endpoint {
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let queryItems: [URLQueryItem]?
    let body: Data?
    
    public init(
        path: String,
        method: HTTPMethod = .get,
        headers: [String: String]? = nil,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryItems = queryItems
        self.body = body
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let networkManager = NetworkManager.shared else {
            throw NetworkError.configurationError
        }
        
        var components = URLComponents()
        components.scheme = networkManager.configuration.scheme
        components.host = networkManager.configuration.baseURL.host
        components.path = path.hasPrefix("/") ? path : "/\(path)"
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        networkManager.configuration.defaultHeaders.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        
        return request
    }
}
