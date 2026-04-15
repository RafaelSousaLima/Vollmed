//
//  HomeViewModel.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

struct HomeViewModel {
    
    // MARK: Attibutes
    let service: HomeServiciable
    
    // MARK: Init
    init(service: HomeServiciable) {
        self.service = service
    }
    
    // MARK: Class methods
    func getSpecialists() async throws -> [Specialist]? {
        let result = try await service.getAllSpecialists()
        switch result {
        case .success(let specialists):
            return specialists
        case .failure(let error):
            throw error
        }
    }
    
}
