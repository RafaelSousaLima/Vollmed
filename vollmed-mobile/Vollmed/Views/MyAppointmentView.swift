//
//  MyAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Lima on 05/06/25.
//

import SwiftUI

struct MyAppointmentView: View {
    
    let service = WebService()
    var authManager = AuthenticationManager.shared
    
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        
        guard let patientId = authManager.getPatientId() else { return }
        
        do {
            if let appointments = try await service.getAllAppointmentFromPatient(patientId: patientId) {
                self.appointments = appointments
            }
        } catch {
            print("Erro ao buscar consultas do paciente:\(error)")
        }
    }
    
    var body: some View {
        VStack {
            if appointments.count == 0 {
                VStack {
                    Text("Não há consulta agendada no momento!")
                        .font(.title2)
                        .bold(true)
                        .foregroundStyle(.cancel)
                        .multilineTextAlignment(.center)
                }
            } else {
                ScrollView(showsIndicators: false) {
                    ForEach(appointments) { appointment in
                        SpecialistCardView(specialist: appointment.specialist, appointment: appointment)
                    }
                }
            }
        }
        .navigationTitle(Text("Minhas consultas"))
        .navigationBarTitleDisplayMode(.large)
        .padding()
        .onAppear() {
            Task {
                await getAllAppointments()
            }
        }
    }
}

#Preview {
    MyAppointmentView()
}
