//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

struct WebService {
    
    let authManager = AuthenticationManager.shared
    
    let imageCache = NSCache<NSString, UIImage>()
    
    private let baseURL = "http://localhost:3000"
    
    func logouPatient() async throws -> Bool {
        let endpoint = "\(baseURL)/auth/logout"
        let url = URLRequest(url: URL(string: endpoint)!)
        
        guard let token = authManager.getToken() else {
            print("Token não informado!!!")
            return false
        }
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
            return true
        }
        return false
    }
    
    func loginRequest(email: String, password: String) async throws -> LoginResponse? {
        let endpoint = "\(baseURL)/auth/login"
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        let jsonData = try JSONEncoder().encode(loginRequest)
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
        return loginResponse
    }
    
    func registerPatient(patient: Patient) async throws -> Patient? {
        let endpoint = "\(baseURL)/paciente"
        let url = URLRequest(url: URL(string: endpoint)!)
        
        let jsonData = try JSONEncoder().encode(patient)
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let patient = try JSONDecoder().decode(Patient.self, from: data)
        return patient
    }
    
    func getAllAppointmentFromPatient(patientId: String) async throws -> [Appointment]? {
        let endpoint = "\(baseURL)/paciente/\(patientId)/consultas"
        
        let urlRequest = URLRequest(url: URL(string: endpoint)!)
        
        guard let token = authManager.getToken() else {
            print("Token não informado!!!")
            return nil
        }
        
        var request = URLRequest(url: urlRequest.url!)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let appointments = try JSONDecoder().decode([Appointment].self, from: data)
        return appointments
    }
    
    func cancelAppointment(appointmentId: String, reasonToCancel: String) async throws -> Bool {
        let endpoint = "\(baseURL)/consulta/\(appointmentId)"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        guard let token = authManager.getToken() else {
            print("Token não informado!!!")
            return false
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: ["motivo_cancelamento": reasonToCancel])
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
           httpResponse.statusCode == 200 {
            return true
        }
        return false
    }
    
    func rescheduleAppointment(appointmentId: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = "\(baseURL)/consulta/\(appointmentId)"
        
        let url = URLRequest(url: URL(string: endpoint)!)
        
        guard let token = authManager.getToken() else {
            print("Token não informado!!!")
            return nil
        }
        
        let requestData: [String: String] = ["data": date]
        
        let jsonData = try JSONSerialization.data(withJSONObject: requestData)
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        
        return appointmentResponse
    }
    
    func scheduleAppointment(specialistId: String, patientId: String, date: String) async throws -> ScheduleAppointmentResponse? {
        let endpoint = "\(baseURL)/consulta"
        let url = URLRequest(url: URL(string: endpoint)!)
        
        guard let token = authManager.getToken() else {
            print("Token não informado!!!")
            return nil
        }
        
        let appointmentData = ScheduleAppointmentRequest(especialist: specialistId, patient: patientId, date: date)
        let appointmentJson = try JSONEncoder().encode(appointmentData)
        
        var request = URLRequest(url: url.url!)
        request.httpMethod = "POST"
        request.setValue( "application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = appointmentJson
        
        print("Appointmente data: ")
        print(appointmentData)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode != 200 {
            return nil
        }
        
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from: data)
        return appointmentResponse
    }
    
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        if let cacheImage = imageCache.object(forKey: imageURL as NSString) {
            return cacheImage
        }
        
        let url = URLRequest(url: URL(string: imageURL)!)
        let (data, _) = try await URLSession.shared.data(from: url.url!)
        imageCache.setObject(UIImage(data: data)!, forKey: imageURL as NSString)
        return UIImage(data: data)
    }
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let url = URLRequest(url: URL(string: "\(baseURL)/especialista")!)
        
        let (date, _) = try await URLSession.shared.data(from: url.url!)
        
        let specialist = try JSONDecoder().decode([Specialist].self, from: date)
        return specialist
    }
}
