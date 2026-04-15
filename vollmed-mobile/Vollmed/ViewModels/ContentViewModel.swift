//
//  ContentViewModel.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

struct ContentViewModel {
    
    var authManager = AuthenticationManager.shared
    let authService: AuthenticationServiceable
    
    init(authService: AuthenticationServiceable) {
        self.authService = authService
    }
    
    func logout() async {
        let result = await authService.logout()
        switch result {
        case .success(_ ):
            authManager.logout()
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
