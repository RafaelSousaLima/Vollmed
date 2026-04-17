//
//  SignInViewModel.swift
//  Vollmed
//
//  Created by Rafael Lima on 16/04/26.
//

import Foundation

struct SignInViewModel {
    
    var authManager = AuthenticationManager.shared
    let authService: AuthenticationServiceable
    
    init(authService: AuthenticationServiceable) {
        self.authService = authService
    }
    
    func login(email: String, password: String) async {
        let loginRequest = LoginRequest(email: email, password: password)
        let response = await authService.login(loginRequest: loginRequest)
        switch response {
        case .success(let response):
            authManager.login(token: response!.token, id: response!.id)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
}
