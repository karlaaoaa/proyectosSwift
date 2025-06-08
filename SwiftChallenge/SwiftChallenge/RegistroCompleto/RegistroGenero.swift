//
//  RegistroFechaView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct RegistroGeneroView: View {
    @State private var genero: Int? = nil
    @StateObject private var dataManager = MLDataManager.shared

    var body: some View {
        NavigationStack {
            
            ZStack {
                // Fondo degradado
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // Título
                    Text("Selecciona tu género")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(20)
                        .multilineTextAlignment(.center)
                    
                    // Campos
                    HStack(spacing: 60) {
                        Button(action: {
                            genero = 1
                            handleSex(1)
                        }) {
                            Image(systemName: "figure.stand")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 90)
                                .padding()
                                .background(Color.white)
                                .foregroundStyle(.black)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(genero == 1 ? Color.gray : Color.clear, lineWidth: 3)
                                )
                        }
                        .buttonStyle(.plain)

                        Button(action: {
                            genero = 0
                            handleSex(0)
                        }) {
                            Image(systemName: "figure.stand.dress")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 90)
                                .padding()
                                .background(Color.white)
                                .foregroundStyle(.black)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(genero == 0 ? Color.gray : Color.clear, lineWidth: 3)
                                )
                        }
                        .buttonStyle(.plain)
                    }
                    
                    NavigationLink(destination: RegistroFechaView()) {
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
                    .disabled(genero == nil)
                    .opacity(genero == nil ? 0.5 : 1.0)
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 36)
            }
        }
    }
    func handleSex(_ valor: Int) {
        dataManager.updateSex(valor)
        print("Valor de sexo: ", valor)
    }
}


#Preview {
    RegistroGeneroView()
}
