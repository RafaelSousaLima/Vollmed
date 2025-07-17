//
//  CancelAppointmentView.swift
//  Vollmed
//
//  Created by Rafael Lima on 20/06/25.
//

import SwiftUI

struct CancelAppointmentView: View {
    
    let service = WebService()
    
    var appointmentId: String
    
    @State private var showAlert = false
    @State private var reasonToCancel: String = ""
    @State private var isAppointmentScheduled = false
    
    @Environment(\.dismiss) var dismiss
    
    func cancelAppointment() async {
        do {
            if try await service.cancelAppointment(appointmentId: appointmentId, reasonToCancel: reasonToCancel) {
                print("Consulta cancelada com sucesso!")
                isAppointmentScheduled = true
            }
        } catch {
            print("Ocorreu um erro ao desmarcar a consulta:\(error)")
            isAppointmentScheduled = false
        }
        showAlert = true
    }
    
    var body: some View {
        VStack(spacing: 16.0) {
            Text("Conte-nos o motivo do cancelamento da sua consulta.")
                .font(.title3)
                .bold(true)
                .foregroundStyle(.accent)
                .padding(.top)
                .multilineTextAlignment(.center)
            TextEditor(text: $reasonToCancel)
                .padding()
                .font(.title3)
                .foregroundStyle(.accent)
                .scrollContentBackground(.hidden)
                .background(Color(.lightBlue).opacity(0.15))
                .cornerRadius(16.0)
                .frame(maxHeight: 300)
            Button(action: {
                Task {
                    await self.cancelAppointment()
                }
            }, label: {
                ButtonView(text: "Cancelar consulta", buttonType: .cancel)
            })
        }
        .padding()
        .navigationTitle("Cancel Appointment")
        .navigationBarTitleDisplayMode(.large)
        .alert(isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: {
                if isAppointmentScheduled {
                    dismiss()
                }
            }, label: {
                Text("OK")
            })
        } message: { isSchedule in
            if isSchedule {
                Text("A consulta foi cancelada com sucesso")
            } else {
                Text("Houve um erro ao cancelar a sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }
    }
}

#Preview {
    CancelAppointmentView(appointmentId: "fdsafsdf")
}
