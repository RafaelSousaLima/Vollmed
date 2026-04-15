//
//  AuthenticationEndpoint.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
}

extension AuthenticationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout:
            return .post
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .logout:
            guard let token = AuthenticationManager.shared.getToken() else {
                return nil
            }
            return [
                "Authorization": "Bearer \(token)",
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: [String : String]? {
        switch self {
        case .logout:
            return nil
        }
    }
    
    
}
