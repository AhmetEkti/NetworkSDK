//
//  NetworkManager.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class NetworkManager {
    public static var shared: NetworkManager!
    public let configuration: NetworkConfiguration
    private let session: URLSession
    private let cache: NetworkCache
    private let cacheManager: CacheManager
    private let retryManager: RetryManager
    
    public init(configuration: NetworkConfiguration) {
        self.configuration = configuration
        
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = configuration.timeoutInterval
        config.timeoutIntervalForResource = configuration.timeoutInterval
        self.session = URLSession(configuration: config)
        
        self.cache = NetworkCache()
        self.cacheManager = CacheManager(cache: cache)
        self.retryManager = RetryManager()
    }
    
    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        cachePolicy: CachePolicy = .ignore,
        retryStrategy: RetryStrategy = .default
    ) async throws -> T {
        if let cachedData = try await cacheManager.handleCache(
            for: endpoint,
            cachePolicy: cachePolicy
        ) {
            return try JSONDecoder().decode(responseType, from: cachedData)
        }
        
        return try await retryManager.execute(retryStrategy: retryStrategy) {
            let (data, response) = try await self.session.data(for: endpoint.asURLRequest())
            
            if case .refreshCache = cachePolicy {
                try await self.cacheManager.saveToCache(
                    data: data,
                    response: response,
                    endpoint: endpoint
                )
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                return try JSONDecoder().decode(responseType, from: data)
            default:
                throw NetworkError.serverError(httpResponse.statusCode)
            }
        }
    }
}
