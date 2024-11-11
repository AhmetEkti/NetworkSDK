//
//  NetworkLogger.swift
//  NetworkSDK
//
//  Created by Ahmet Ekti on 11/11/24.
//

import Foundation

public class NetworkLogger {
    public static func log(request: URLRequest) {
        print("⚡️ REQUEST:")
        print("URL: \(request.url?.absoluteString ?? "")")
        print("Method: \(request.httpMethod ?? "")")
        print("Headers: \(request.allHTTPHeaderFields ?? [:])")
        if let body = request.httpBody {
            print("Body: \(String(data: body, encoding: .utf8) ?? "")")
        }
    }
    
    public static func log(response: URLResponse, data: Data?) {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        print("📥 RESPONSE:")
        print("Status Code: \(httpResponse.statusCode)")
        if let data = data,
           let json = try? JSONSerialization.jsonObject(with: data, options: []) {
            print("Response: \(json)")
        }
    }
}
