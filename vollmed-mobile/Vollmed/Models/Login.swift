//
//  Login.swift
//  Vollmed
//
//  Created by Rafael Lima on 12/01/26.
//

import Foundation

struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password = "senha"
    }
}

struct LoginResponse: Identifiable, Codable {
    let id: String
    let token: String
    let auth: Bool
    let rota: String
}
