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
    case custom(error: [String: Any]?)
    
    var customMessage: String? {
        switch self {
        case .decodeFailed:
            return "Erro de decodificação"
        case .unauthorized:
            return "Sessão expirada"
        case .custom(let errorData):
            if let jsonError = errorData?["error"] as? [String: Any] {
                let message = jsonError["message"] as? String ?? ""
                return message
            }
            return "Ocorreu um erro ao carregar as informações"
        default:
            return "Erro desconhecido (contacte o administrador do sistema)"
        }
    }
    
}
