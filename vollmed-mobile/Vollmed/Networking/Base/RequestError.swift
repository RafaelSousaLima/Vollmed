//
//  RequestError.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

enum RequestError: Error {
    case decodeFailed
    case invalidURL
    case noResponse
    case unauthorized
    case unknown
    case custom(_error: [String: Any])
    
    var customMessage: String? {
        switch self {
        case .decodeFailed:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        default:
            return "Erro desconhecido (contacte o administrador do sistema)"
        }
    }
    
}
