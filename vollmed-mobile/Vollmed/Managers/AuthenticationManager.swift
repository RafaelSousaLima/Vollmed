//
//  AuthenticationManager.swift
//  Vollmed
//
//  Created by Rafael Lima on 06/04/26.
//

import Foundation

class AuthenticationManager: ObservableObject {
    
    static let shared = AuthenticationManager()
    
    @Published private var token: String?
    @Published private var patientId: String?
    
    private init() {
        self.token = KeyChainHelper.get(for: TokenKeyChainHelper.token.rawValue)
        self.patientId = KeyChainHelper.get(for: TokenKeyChainHelper.patientID.rawValue)
    }
    
    private func saveToken(token: String) {
        KeyChainHelper.save(value: token, key: TokenKeyChainHelper.token.rawValue)
        DispatchQueue.main.async {
            self.token = token
        }
        self.token = token
    }
    
    private func removeToken() {
        KeyChainHelper.remove(for: TokenKeyChainHelper.token.rawValue)
        DispatchQueue.main.async {
            self.token = nil
        }
        self.token = nil
    }
    
    private func savePatinentID(id: String) {
        KeyChainHelper.save(value: id, key: TokenKeyChainHelper.patientID.rawValue)
        DispatchQueue.main.async {
            self.patientId = id
        }
        self.patientId = id
    }
    
    private func removePatientID() {
        KeyChainHelper.remove(for: TokenKeyChainHelper.patientID.rawValue)
        DispatchQueue.main.async {
            self.patientId = nil
        }
        self.token = nil
    }
    
    func getPatientId() -> String? {
        return patientId
    }
    
    func getToken() -> String? {
        return token
    }
    
    func login(token: String, id: String) {
        saveToken(token: token)
        savePatinentID(id: id)
    }
    
    func logout() {
        removeToken()
        removePatientID()
    }
    
}
