//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Lima on 22/05/25.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    
    let authManager = AuthenticationManager.shared
    
    var specialistId: String
    var isRescheduleView: Bool
    var appointmentId: String?
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    
    @Environment(\.dismiss) var dismiss
    
    init(specialistId: String, isRescheduleView: Bool = false, appointmentId: String? = nil) {
        self.specialistId = specialistId
        self.isRescheduleView = isRescheduleView
        self.appointmentId = appointmentId
    }
    
    func rescheduleAppointment() async {
        guard let appointmentId else {
            print("Erro ao obter o ID da consulta")
            return
        }
        
        do {
            if let _
                = try await service.rescheduleAppointment(appointmentId: appointmentId, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            print("Erro ao remarcar a consulta: \(error.localizedDescription)")
            isAppointmentScheduled = false
        }
        showAlert = true
    }
    
    func scheduleAppointment() async {
        guard let patientId = authManager.getPatientId() else {
            return
        }
        do {
            if let _ = try await service.scheduleAppointment(specialistId: specialistId, patientId: patientId, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consult: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        VStack {
            Text("Selecione a data e o horário da consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            DatePicker("Escolha a data da consulta", selection: $selectedDate, in: Date()...).datePickerStyle(.graphical)
            Button(action: {
                Task {
                    if isRescheduleView {
                        await rescheduleAppointment()
                    } else {
                        await scheduleAppointment()
                    }
                }
            }, label: {
                ButtonView(text: isRescheduleView ? "Reagendar" : "Agendar Consulta")
            })
        }
        .padding()
        .navigationTitle(isRescheduleView ? "Reagendar" : "Agendar Consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear() {
            UIDatePicker.appearance().minuteInterval = 30
        }.alert(isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: {
                if isAppointmentScheduled {
                    dismiss()
                }
            }, label: {
                Text("OK")
            })
        } message: { isSchedule in
            if isSchedule {
                Text("A consulta foi \(isRescheduleView  ? "reagendada" : "agendada") com sucesso!")
            } else {
                Text("Houve um erro ao \(isRescheduleView ? "reagendada" : "agendada") a sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    ScheduleAppointmentView(specialistId: "c84k5kf", isRescheduleView: false)
}
