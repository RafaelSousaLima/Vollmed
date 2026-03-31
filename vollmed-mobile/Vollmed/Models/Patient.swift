//
//  Patient.swift
//  Vollmed
//
//  Created by Rafael Lima on 08/10/25.
//

import Foundation

struct Patient: Identifiable, Codable {
    let id: String?
    let cpf: String
    let name: String
    let email: String
    let password: String
    let phoneNumber: String
    let healthPlan: String
    
    enum CodingKeys: String , CodingKey {
        case id, cpf, email
        case name = "nome"
        case password = "senha"
        case phoneNumber = "telefone"
        case healthPlan = "planoSaude"
    }
    
}
