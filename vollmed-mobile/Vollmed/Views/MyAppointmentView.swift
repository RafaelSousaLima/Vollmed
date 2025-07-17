//
//  MyAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Lima on 05/06/25.
//

import SwiftUI

struct MyAppointmentView: View {
    
    let service = WebService()
    
    @State private var appointments: [Appointment] = []
    
    func getAllAppointments() async {
        do {
            appointments = try await service.getAllAppointmentFromPatient(patientId: "4133b2cd-faab-4013-a2dd-e5ffd78bd553")!
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
