//
//  SpecialistCardView.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import SwiftUI

struct SpecialistCardView: View {
    
    let service = WebService()
    
    var specialist: Specialist
    var appointment: Appointment?
    
    @State var imageSpecialist: UIImage?
    
    func downloadImage() async {
        do {
            if let image = try await service.downloadImage(from: specialist.imageUrl) {
                self.imageSpecialist = image
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16.0) {
                if let imageSpecialist {
                    Image(uiImage: imageSpecialist)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(specialist.name)
                        .font(.title3)
                        .bold()
                    Text(specialist.specialty)
                    if let appointment {
                        Text(appointment.date.convertDateToString())
                    }
                }
            }
            
            if let appointment {
                HStack {
                    NavigationLink() {
                        ScheduleAppointmentView(specialistId: specialist.id, isRescheduleView: true, appointmentId: appointment.id)
                    } label: {
                        ButtonView(text: "Remarcar")
                    }
                    
                    NavigationLink() {
                        CancelAppointmentView(appointmentId: appointment.id)
                    } label: {
                        ButtonView(text: "Cancelar", buttonType: .cancel)
                    }
                }
            } else {
                NavigationLink {
                    ScheduleAppointmentView(specialistId: specialist.id)
                } label: {
                    ButtonView(text: "Agendar consulta")
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.lightBlue).opacity(0.15))
        .cornerRadius(16.0)
        .task {
            await downloadImage()
        }
    }
}

#Preview {
    SpecialistCardView(specialist:
                        Specialist(id: "c84k5kf",
                                   name: "Dr. Carlos Alberto",
                                   crm: "123456",
                                   imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                                   specialty: "Neurologia",
                                   email: "carlos.alberto@example.com",
                                   phoneNumber: "(11) 99999-9999"
                                  ), appointment: Appointment(id: "fdasfdsafdasf", date: Date().description, specialist: Specialist(id: "c84k5kf",
                                                                                                                                    name: "Dr. Carlos Alberto",
                                                                                                                                    crm: "123456",
                                                                                                                                    imageUrl: "https://images.unsplash.com/photo-1637059824899-a441006a6875?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=752&q=80",
                                                                                                                                    specialty: "Neurologia",
                                                                                                                                    email: "carlos.alberto@example.com",
                                                                                                                                    phoneNumber: "(11) 99999-9999"
                                                                                                                                   )))
}
