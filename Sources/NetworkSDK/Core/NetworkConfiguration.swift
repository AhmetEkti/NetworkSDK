//
//  NetworkConfiguration.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

public struct NetworkConfiguration {
    public let baseURL: URL
    public let scheme: String
    public let defaultHeaders: [String: String]
    public let timeoutInterval: TimeInterval
    
    public init(
        baseURL: URL,
        scheme: String = "https",
        defaultHeaders: [String: String] = [:],
        timeoutInterval: TimeInterval = 30
    ) {
        self.baseURL = baseURL
        self.scheme = scheme
        self.defaultHeaders = defaultHeaders
        self.timeoutInterval = timeoutInterval
    }
}

