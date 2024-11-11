//
//  CacheManager.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class CacheManager {
    private let cache: NetworkCache
    
    init(cache: NetworkCache) {
        self.cache = cache
    }
    
    public func handleCache(
        for endpoint: Endpoint,
        cachePolicy: CachePolicy
    ) async throws -> Data? {
        guard case .useCache = cachePolicy else { return nil }
        
        let request = try endpoint.asURLRequest()
        let key = request.url?.absoluteString ?? ""
        
        if let memoryCache = cache.getFromMemory(for: key),
           cache.isCacheValid(memoryCache, maxAge: cachePolicy.maxAge) {
            return memoryCache.data
        }
        
        if let diskCache = cache.getFromDisk(for: key),
           cache.isCacheValid(diskCache, maxAge: cachePolicy.maxAge) {
            cache.setInMemory(response: diskCache, for: key)
            return diskCache.data
        }
        
        return nil
    }
    
    public func saveToCache(
        data: Data,
        response: URLResponse,
        endpoint: Endpoint
    ) async throws {
        guard let httpResponse = response as? HTTPURLResponse,
              let request = try? endpoint.asURLRequest() else { return }
        
        let headers = httpResponse.allHeaderFields as? [String: String]
        let cachedResponse = CachedResponse(data: data, headers: headers)
        let key = request.url?.absoluteString ?? ""
        
        cache.setInMemory(response: cachedResponse, for: key)
        cache.setOnDisk(response: cachedResponse, for: key)
    }
}
