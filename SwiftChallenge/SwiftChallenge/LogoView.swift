
//
//  LogoView.swift
//  SwiftChallenge
//
//  Created by Alumno on 08/06/25.
//

import SwiftUI

struct LogoView: View {
    @State private var correo: String = ""
    @State private var password: String = ""
    @State private var isSecure: Bool = true

    var body: some View {
        NavigationStack {
            
            ZStack {
                // Fondo degradado
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Título
                    Image("gluxxylogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                    
                    
                    
                }
                .padding(.horizontal, 36)
            }
        }
    }
}

#Preview {
    LogoView()
}

