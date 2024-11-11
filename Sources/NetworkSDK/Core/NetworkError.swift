//
//  NetworkError.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

public enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case configurationError
    case custom(String)
    case cacheError
    case cacheExpired
    case retryLimitExceeded
    case noInternetConnection
    case timeout
    case invalidResponse
}
