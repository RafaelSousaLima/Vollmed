//
//  SkaletonView.swift
//  Vollmed
//
//  Created by Rafael Lima on 28/04/26.
//

import SwiftUI

private struct SkaletonContentView: View {
    
    private var placeholder: String = "**********************************************"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                    .mask(
                        Circle().frame(width: 60, height: 60).redactedAnimation()
                    )
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading, spacing: 8.0) {
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                        .mask(Text(placeholder).redacted(reason: .placeholder).redactedAnimation())
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]), startPoint: .leading, endPoint: .trailing)
                        .mask(Text(placeholder).redacted(reason: .placeholder).redactedAnimation())
                }
            }
        }
    }
}

struct SkaletonView: View {
    var body: some View {
        VStack(spacing: 35) {
            ForEach(0..<10) { _ in
                SkaletonContentView()
            }
        }
    }
}

#Preview {
    SkaletonView()
}
