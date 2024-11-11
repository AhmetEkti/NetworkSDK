//
//  RetryManager.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class RetryManager {
    public func execute<T>(
        retryStrategy: RetryStrategy,
        operation: @escaping () async throws -> T
    ) async throws -> T {
        var lastError: Error?
        
        for attempt in 0...retryStrategy.maxRetries {
            do {
                return try await operation()
            } catch let error {
                lastError = error
                
                if attempt < retryStrategy.maxRetries,
                   retryStrategy.shouldRetry(error) {
                    try await Task.sleep(nanoseconds: UInt64(retryStrategy.retryInterval * 1_000_000_000))
                    continue
                }
                throw error
            }
        }
        
        throw lastError ?? NetworkError.custom("Unknown error")
    }
}
