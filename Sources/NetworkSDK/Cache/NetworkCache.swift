//
//  NetworkCache.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class NetworkCache {
    private let cache = NSCache<NSString, CachedResponse>()
    private let fileManager = FileManager.default
    private let cacheDirectory: URL
    private let queue = DispatchQueue(label: "com.networksdk.cache")
    
    public init() {
        let cacheURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        cacheDirectory = cacheURL.appendingPathComponent("NetworkCache")
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    public func setInMemory(response: CachedResponse, for key: String) {
        cache.setObject(response, forKey: key as NSString)
    }
    
    public func getFromMemory(for key: String) -> CachedResponse? {
        return cache.object(forKey: key as NSString)
    }
    
    public func setOnDisk(response: CachedResponse, for key: String) {
        queue.async {
            let fileURL = self.cacheDirectory.appendingPathComponent(key.sha256())
            try? JSONEncoder().encode(response).write(to: fileURL)
        }
    }
    
    public func getFromDisk(for key: String) -> CachedResponse? {
        let fileURL = cacheDirectory.appendingPathComponent(key.sha256())
        guard let data = try? Data(contentsOf: fileURL),
              let response = try? JSONDecoder().decode(CachedResponse.self, from: data) else {
            return nil
        }
        return response
    }
    
    public func clearCache() {
        cache.removeAllObjects()
        try? fileManager.removeItem(at: cacheDirectory)
        try? fileManager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
    
    public func isCacheValid(_ response: CachedResponse, maxAge: TimeInterval?) -> Bool {
        guard let maxAge = maxAge else { return true }
        let expirationDate = response.timestamp.addingTimeInterval(maxAge)
        return Date() < expirationDate
    }
}
