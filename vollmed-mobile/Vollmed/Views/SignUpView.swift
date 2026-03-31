//
//  SignUpView.swift
//  Vollmed
//
//  Created by Rafael Lima on 08/10/25.
//

import SwiftUI

struct SignUpView: View {
    
    let service = WebService()
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var cpf: String = ""
    @State private var phoneNumber: String = ""
    @State private var chosenHealhPlan: String
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var isPatientRegistered: Bool = false
    @State private var navigationToSignInView: Bool = false
    
    let healtPlans: [String] = [
        "Amil",
        "Unimed",
        "Bradesco Saúde",
        "SulAmérica",
        "Hapvida",
        "Notredame Intermédica",
        "São Francisco Saúde",
        "Golden Cross",
        "Medical Saúde",
        "América Saúde",
        "Outros",
    ]
    
    init() {
        chosenHealhPlan = self.healtPlans.first ?? ""
    }
    
    func registrer() async {
        let patient = Patient(id: nil, cpf: cpf, name: name, email: email, password: password, phoneNumber: phoneNumber, healthPlan: chosenHealhPlan)
        do {
            if let _ = try await service.registerPatient(patient: patient) {
                isPatientRegistered = true
            } else {
                isPatientRegistered = false
            }
        } catch {
            isPatientRegistered = false
            print("Ocorreu um erro ao cadastrar o paciente: \(error)")
        }
        showAlert = true
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
                    .padding()
                
                Text("Olá, boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.accent)
                
                Text("Insira seus dados para criar uma conta")
                    .font(.title3)
                    .foregroundStyle(.gray)
                    .padding(.bottom)
                
                Text("Nome")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu nome completo", text: $name)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .autocorrectionDisabled()
                
                Text("Email")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu email", text: $email)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Text("CPF")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu CPF", text: $cpf)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .keyboardType(.numberPad)
                
                Text("Número de telefone")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                TextField("Insira seu número de telefone", text: $phoneNumber)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                    .keyboardType(.numberPad)
                
                Text("Senha")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                SecureField("Insira sua senha", text: $password)
                    .padding(14)
                    .background(Color.gray.opacity(0.25))
                    .cornerRadius(14.0)
                
                Text("Selecione seu plano de saúde")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                
                Picker("Plano de saúde", selection: $chosenHealhPlan) {
                    ForEach(healtPlans, id: \.self) { healhPlan in
                        Text(healhPlan)
                    }
                }
                
                Button(action: {
                    Task {
                        await registrer()
                    }
                }, label: {
                    ButtonView(text: "Cadastrar")
                })
                
                NavigationLink {
                    SignInView()
                } label: {
                    Text("Já possui uma conta? Faça o login!")
                        .bold()
                        .foregroundStyle(.accent)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
        .padding()
        .alert(isPatientRegistered ? "Sucesso" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: $isPatientRegistered) { _ in
            Button(action: {
                navigationToSignInView = true
            }, label: {
                Text("Ok")
            })
        } message: { _ in
            if isPatientRegistered {
                Text("O paciente foi cadastrado com sucesso!")
            } else {
                Text("Houve um erro ao cadastrar o paciente. Por favor tente novamente.")
            }
        }.navigationDestination(isPresented: $navigationToSignInView) {
            SignInView()
        }
    }
}

#Preview {
    SignUpView()
}
