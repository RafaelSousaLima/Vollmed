//
//  Endpoint.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var scheme: String {
        return "http"
    }
    
    var host: String {
        return "localhost"
    }
    
}
