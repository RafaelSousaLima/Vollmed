//
//  HomeEndpoint.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

enum HomeEndpoint {
    case getAllSpecialists
}

extension HomeEndpoint: Endpoint {
    var path: String {
        switch self {
        case .getAllSpecialists:
            return "/especialista"
        }
    }
    
    var method: RequestMethod {
        switch self {
        case .getAllSpecialists:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
    
    var body: Data? {
        switch self {
        case .getAllSpecialists:
            return nil
        }
    }
    
}
