//
//  SignInView.swift
//  Vollmed
//
//  Created by Rafael Lima on 29/08/25.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    
    let service = WebService()
    
    func login() async {
        do {
            if let result = try await service.loginRequest(email: email, password: password) {
                print(result)
            } else {
                showAlert = true
            }
        } catch {
            showAlert = true
            print("Ocorreu um erro no login: \(error)")
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 36.0, alignment: .center)
            
            Text("Olá!!")
                .font(.title2)
                .bold()
                .foregroundStyle(.accent)
            
            Text("Email")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            TextField("Email", text: $email)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .autocorrectionDisabled()
                .keyboardType(.emailAddress)
                .textInputAutocapitalization(.never)
            
            Text("Senha")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            SecureField("Senha", text: $password)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
            
            Button(action: {
                Task {
                    await login()
                }
            }, label: {
                ButtonView(text: "Login")
            })
            
            NavigationLink {
                SignUpView()
            } label: {
                Text("Não possui uma conta? Cadastre-se")
                    .bold()
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .padding()
        .navigationBarBackButtonHidden()
        .alert("Algo de errado!", isPresented: $showAlert) {
            Button(action: {}, label: {
                Text("Ok")
            })
        } message: {
            Text("Houve um erro ao entrar na sua conta. Por favor tente novamente.")
        }
    }
}


#Preview {
    SignInView()
}
