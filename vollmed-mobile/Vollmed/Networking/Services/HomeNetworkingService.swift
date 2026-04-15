//
//  HomeNetworkingService.swift
//  Vollmed
//
//  Created by Rafael Lima on 13/04/26.
//

import Foundation

protocol HomeServiciable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError>
}

struct HomeNetworkingService: HTTPClient, HomeServiciable {
    func getAllSpecialists() async throws -> Result<[Specialist]?, RequestError> {
        return await sendRequest(endpoint: HomeEndpoint.getAllSpecialists, responseModel: [Specialist].self)
    }
}
