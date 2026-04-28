//
//  HTTPClient.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError>
}

extension HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type?) async -> Result<T?, RequestError> {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.port = 3000
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            request.httpBody = body
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request,delegate: nil)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(RequestError.noResponse)
            }
            switch response.statusCode {
            case 200...299:
                guard let responseModel = responseModel else {
                    return .success(nil)
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decodeFailed)
                }
                return .success(decodedResponse)
            case 400:
                let errorResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
                return .failure(.custom(error: errorResponse))
            default:
                print(response.description)
                return .failure(.unknown)
            }
            
        } catch {
            print(error.localizedDescription)
            return .failure(.unknown)
        }
        
    }
}
