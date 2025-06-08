//
//  RegisterView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct RegisterView: View {
    @State private var nombre = ""
    @State private var correo = ""
    @State private var password = ""

    var body: some View {
        NavigationStack {
            
            ZStack {
                // Fondo degradado
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Título
                    Text("Registrate aquí")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(20)
                    
                    // Campos
                    TextField("Nombre completo", text: $nombre)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                        )
                    TextField("Correo", text: $correo)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                        )
                    TextField("Contraseña", text: $password)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                        )
                    let camposCompletos = !nombre.isEmpty && !correo.isEmpty && !password.isEmpty
                    
                    NavigationLink(destination: RegistroGeneroView()) {
                        Text("Siguiente")
                            .foregroundColor(.black)
                            .fontWeight(.none)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                            .cornerRadius(10)
                            .padding(.horizontal, 80)
                            .padding(15)
                    }
                    .disabled(!camposCompletos)
                    .opacity(camposCompletos ? 1.0 : 0.5)
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 36)
            }
        }
    }
}


#Preview {
    RegisterView()
}
