//
//  CachedResponse.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class CachedResponse: NSObject, Codable {
    public let data: Data
    public let timestamp: Date
    public let headers: [String: String]?
    
    public init(data: Data, timestamp: Date = Date(), headers: [String: String]? = nil) {
        self.data = data
        self.timestamp = timestamp
        self.headers = headers
        super.init()
    }
}
