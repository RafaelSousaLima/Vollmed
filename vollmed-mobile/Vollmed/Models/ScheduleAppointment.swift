//
//  ScheduleAppointment.swift
//  Vollmed
//
//  Created by Rafael Lima on 22/05/25.
//

import Foundation

struct ScheduleAppointmentRequest: Codable {
    var especialist: String
    var patient: String
    var date: String
    
    enum CodingKeys: String, CodingKey {
         case especialist = "especialista"
        case patient = "paciente"
        case date = "data"
    }
    
}

struct ScheduleAppointmentResponse: Identifiable, Codable {
    var id: String?
    var especialist: String?
    var patient: String?
    var date: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case especialist = "especialista"
        case patient = "paciente"
        case date = "data"
    }
}

