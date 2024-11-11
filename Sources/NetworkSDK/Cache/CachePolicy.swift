//
//  CachePolicy.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

public enum CachePolicy {
    case ignore
    case useCache(maxAge: TimeInterval)
    case refreshCache
    case useCacheElseLoad
    
    public var maxAge: TimeInterval? {
        switch self {
        case .useCache(let maxAge):
            return maxAge
        default:
            return nil
        }
    }
    
    public static func withMaxAge(_ maxAge: TimeInterval) -> CachePolicy {
        return .useCache(maxAge: maxAge)
    }
}
