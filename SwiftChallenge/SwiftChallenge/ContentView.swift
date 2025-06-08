//
//  ContentView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct ContentView: View {
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
                    Text("Iniciar Sesión")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(20)
                    
                    // Campo de usuario
                    TextField("Correo", text: $correo)
                        .padding()
                        .foregroundColor(.black)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(1), lineWidth: 1)
                        )
                    
                    // Campo de contraseña con opción de ver/ocultar
                    ZStack(alignment: .trailing) {
                        if isSecure {
                            SecureField("Contraseña", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(1), lineWidth: 1)
                                )
                        } else {
                            TextField("Contraseña", text: $password)
                                .padding()
                                .background(Color.white.opacity(0.1))
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black.opacity(1), lineWidth: 1)
                                )
                        }
                        
                        Button(action: {
                            isSecure.toggle()
                        }) {
                            Image(systemName: self.isSecure ? "eye.slash" : "eye")
                                .foregroundColor(.black)
                               .padding(.trailing, 16)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    // Botón de login
                    Button(action: {
                        // Lógica de inicio de sesión
                    }) {
                        Text("Entrar")
                            .foregroundColor(.black)
                            .fontWeight(.none)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                            .cornerRadius(10)
                            .padding(.horizontal, 80)
                            .padding(15)
                    }
                    .buttonStyle(.plain)
                    
                    // Opción de registro
                    HStack {
                        Text("¿No tienes cuenta?")
                            .foregroundColor(.black.opacity(0.7))
                        NavigationLink(destination: RegisterView()) {
                            Text("Registrate")
                                .foregroundColor(.black)
                                .underline()
                                .fontWeight(.semibold)
                        }
                        
                    }.buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 36)
            }
        }
    }
}

#Preview {
    ContentView()
}

