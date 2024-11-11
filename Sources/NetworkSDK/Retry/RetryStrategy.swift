//
//  RetryStrategy.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public struct RetryStrategy {
    public let maxRetries: Int
    public let retryInterval: TimeInterval
    public let shouldRetry: (Error) -> Bool
    
    public static let `default` = RetryStrategy(
        maxRetries: 3,
        retryInterval: 1.0,
        shouldRetry: { error in
            switch error {
            case NetworkError.serverError(let code):
                return (500...599).contains(code)
            case NetworkError.noInternetConnection,
                 NetworkError.timeout:
                return true
            default:
                return false
            }
        }
    )
    
    public init(
        maxRetries: Int = 3,
        retryInterval: TimeInterval = 1.0,
        shouldRetry: @escaping (Error) -> Bool
    ) {
        self.maxRetries = maxRetries
        self.retryInterval = retryInterval
        self.shouldRetry = shouldRetry
    }
}
