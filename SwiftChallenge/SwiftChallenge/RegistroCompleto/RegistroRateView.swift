//
//  RegistroRateView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct RegistroRateView: View {
    @State private var saludValor: Int? = nil
    @StateObject private var dataManager = MLDataManager.shared

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {

                    // Título
                    Text("Tu salud general")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    // Pregunta
                    VStack(spacing: 20) {
                        Text("¿Qué tan buena consideras tu salud?")
                            .font(.title3)
                            .fontWeight(.semibold)

                        HStack(spacing: 20) {
                            ForEach(1...5, id: \.self) { number in
                                Button(action: {
                                    saludValor = number
                                    handleGenHealth(number)
                                }) {
                                    Text("\(number)")
                                        .font(.title3)
                                        .frame(width: 50, height: 50)
                                        .background(saludValor == number ? Color.green.opacity(0.6) : Color.gray.opacity(0.2))
                                        .foregroundColor(.black)
                                        .clipShape(Circle())
                                        .overlay(
                                            Circle()
                                                .stroke(saludValor == number ? Color.green : Color.clear, lineWidth: 2)
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding(.bottom, 90)


                    NavigationLink(destination: LoadingClusterView()) {
                        Text("Siguiente")
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                            .cornerRadius(10)
                            .padding(.horizontal, 80)
                    }
                    .buttonStyle(.plain)
                    .disabled(saludValor == nil)
                    .opacity(saludValor == nil ? 0.5 : 1.0)
                    
                }
                .padding()
            }
        }
    }
    func handleGenHealth(_ valor: Int) {
        dataManager.updateGenHlth(valor)
        print("Gen Health updated t:", valor)
    }

}

#Preview {
    RegistroRateView()
}
