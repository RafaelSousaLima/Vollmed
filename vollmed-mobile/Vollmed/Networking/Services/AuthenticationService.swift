//
//  AuthenticationService.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

protocol AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError>
    func login(loginRequest: LoginRequest) async -> Result<LoginResponse?, RequestError>
}

struct AuthenticationService: HTTPClient, AuthenticationServiceable {
    func logout() async -> Result<Bool?, RequestError> {
        return await sendRequest(endpoint: AuthenticationEndpoint.logout, responseModel: nil)
    }
    
    func login(loginRequest: LoginRequest) async -> Result<LoginResponse?, RequestError> {
        return await sendRequest(endpoint: AuthenticationEndpoint.login(loginRequest: loginRequest), responseModel: LoginResponse.self)
    }
    
}
