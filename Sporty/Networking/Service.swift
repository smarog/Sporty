//
//  Service.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

enum ServiceMethod: String {
    case get = "GET"
}


protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var method: ServiceMethod { get }
}


extension Service {
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        return urlComponents?.url
    }
    
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL is nil")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        return request
    }
}
