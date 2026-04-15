//
//  HomeView.swift
//  Vollmed
//
//  Created by Rafael Lima on 22/05/25.
//

import SwiftUI

struct HomeView: View {
    
    let service = WebService()
    var viewModel: HomeViewModel = HomeViewModel(service: HomeNetworkingService())
    
    @State var specialists: [Specialist] = []
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                Image(.logo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .padding(.vertical, 32)
                Text("Boas-vindas!")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(Color(.lightBlue))
                Text("Veja abaixo os especialistas da Vollmed disponíveis e marque já a sua consulta!")
                    .font(.title3)
                    .bold()
                    .foregroundStyle(.accent)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 16)
                ForEach(specialists) { specialist in
                    SpecialistCardView(specialist: specialist)
                        .padding(.bottom, 8)
                }
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .onAppear {
            Task {
                do {
                    guard let response = try await viewModel.getSpecialists() else { return }
                    self.specialists = response
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
