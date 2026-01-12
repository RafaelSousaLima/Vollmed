//
//  InputView.swift
//  Vollmed
//
//  Created by Rafael Lima on 08/10/25.
//

import SwiftUI

struct InputView: View {
    
    @State private var name: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Nome")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
            
            TextField("Insira seu nome completo", text: $name)
                .padding(14)
                .background(Color.gray.opacity(0.25))
                .cornerRadius(14.0)
                .autocorrectionDisabled()
        }
        .padding()
    }
}

#Preview {
    InputView()
}
