//
//  RegistroCPView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//
//Cambios re importantesptm

import SwiftUI

struct RegistroCPView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var dataManager = MLDataManager.shared
    
    @State private var colesterolAlto: Bool? = nil
    @State private var presionAlta: Bool? = nil
    @State private var tieneDiabetes: Bool? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    
                    Text("Condiciones de salud")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Pregunta 1
                    VStack(spacing: 12) {
                        Text("¿Tienes colesterol alto?")
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 40) {
                            BooleanOpcionBoton(titulo: "Sí", valor: true, seleccionado: colesterolAlto == true) {
                                colesterolAlto = true
                                dataManager.updateHighChol(true)
                            }
                            .buttonStyle(.plain)
                            BooleanOpcionBoton(titulo: "No", valor: false, seleccionado: colesterolAlto == false) {
                                colesterolAlto = false
                                dataManager.updateHighChol(false)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    // Pregunta 2
                    VStack(spacing: 12) {
                        Text("¿Tienes presión arterial alta?")
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 40) {
                            BooleanOpcionBoton(titulo: "Sí", valor: true, seleccionado: presionAlta == true) {
                                presionAlta = true
                                dataManager.updateHighBP(true)
                            }
                            .buttonStyle(.plain)
                            BooleanOpcionBoton(titulo: "No", valor: false, seleccionado: presionAlta == false) {
                                presionAlta = false
                                dataManager.updateHighBP(false)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    // Pregunta 3
                    VStack(spacing: 12) {
                        Text("¿Tienes algún tipo de diabetes?")
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 40) {
                            BooleanOpcionBoton(titulo: "Sí", valor: true, seleccionado: tieneDiabetes == true) {
                                tieneDiabetes = true
                                dataManager.updateDiabetes(true)
                            }
                            .buttonStyle(.plain)
                            BooleanOpcionBoton(titulo: "No", valor: false, seleccionado: tieneDiabetes == false) {
                                tieneDiabetes = false
                                dataManager.updateDiabetes(false)
                                
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    
                    let camposCompletos = colesterolAlto != nil && presionAlta != nil && tieneDiabetes != nil

                    NavigationLink(destination: RegistroRateView()) {
                        Text("Siguiente")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                            .cornerRadius(10)
                            .padding(.horizontal, 80)
                    }
                    .buttonStyle(.plain)
                    .disabled(!camposCompletos)
                    .opacity(camposCompletos ? 1.0 : 0.5)
                }
                .padding()
            }
        }
        .onAppear {
            // Cargar datos existentes del dataManager si los hay
            colesterolAlto = dataManager.inputData.HighChol
            presionAlta = dataManager.inputData.HighBP
            tieneDiabetes = dataManager.inputData.Diabetes
        }
    }
}

struct BooleanOpcionBoton: View {
    let titulo: String
    let valor: Bool
    let seleccionado: Bool
    let accion: () -> Void

    var body: some View {
        Button(action: accion) {
            Text(titulo)
                .font(.title3)
                .padding()
                .frame(width: 80)
                .background(seleccionado ? Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6) : Color.gray.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(seleccionado ? Color.green : Color.clear, lineWidth: 2)
                )
        }
    }
}

#Preview {
    RegistroCPView()
}
