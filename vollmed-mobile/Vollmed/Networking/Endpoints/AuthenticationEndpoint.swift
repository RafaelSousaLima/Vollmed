//
//  AuthenticationEndpoint.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

enum AuthenticationEndpoint {
    case logout
    case login(loginRequest: LoginRequest)
}

extension AuthenticationEndpoint: Endpoint {
    var path: String {
        switch self {
        case .logout:
            return "/auth/logout"
        case .login:
            return "/auth/login"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .logout, .login:
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
        case .login:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .logout:
            return nil
        case .login(let loginRequest):
            do {
                return try JSONEncoder().encode(loginRequest)
            } catch {
                #if DEBUG
                print("[AuthenticationEndpoint] Failed to encode LoginRequest: \(error)")
                #endif
                return nil
            }
        }
    }
    
    
}
