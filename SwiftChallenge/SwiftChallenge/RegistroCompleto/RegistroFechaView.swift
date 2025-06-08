//
//  RegistroFechaView.swift
//  SwiftChallenge
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct RegistroFechaView: View {
    @StateObject private var dataManager = MLDataManager.shared
    @State private var birthday = Date()
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                // Fondo degradado
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    // Título
                    Text("Selecciona tu fecha de nacimiento")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(20)
                        .multilineTextAlignment(.center)
                    
                    // Campos
                    DatePicker("Fecha de nacimiento", selection: $birthday, displayedComponents: [.date])
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .environment(\.locale, Locale(identifier: "es_ES"))
                        .onChange(of: birthday) { oldValue, newValue in
                            // 🔧 CORRECCIÓN: Llamar calculateAge cuando cambia la fecha
                            let age = calculateAge(from: newValue)
                            print("🎂 [RegistroFecha] Fecha seleccionada: \(newValue)")
                            print("🎂 [RegistroFecha] Edad calculada: \(age)")
                        }
                    
                    // Mostrar edad calculada para debugging
                    if let currentAge = dataManager.inputData.Age {
                        Text("Edad calculada: \(currentAge) años")
                            .font(.title2)
                            .foregroundColor(.secondary)
                            .padding(.top, 10)
                    }
                    
                    NavigationLink(destination: RegistroPAView()) {
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
                    .buttonStyle(.plain)
                    
                }
                .padding(.horizontal, 36)
            }
        }
        .onAppear {
            print("🔍 [RegistroFecha] Vista apareció - Verificando datos existentes...")
            
            // Cargar fecha existente del dataManager si hay una edad guardada
            if let existingAge = dataManager.inputData.Age {
                print("✅ [RegistroFecha] Edad existente encontrada: \(existingAge)")
                // Calcular fecha aproximada basada en la edad
                let calendar = Calendar.current
                if let approximateDate = calendar.date(byAdding: .year, value: -existingAge, to: Date()) {
                    birthday = approximateDate
                    print("📅 [RegistroFecha] Fecha aproximada calculada: \(approximateDate)")
                }
            } else {
                print("⚠️ [RegistroFecha] No hay edad existente, usando fecha actual")
                // Calcular edad inicial con la fecha actual
                let initialAge = calculateAge(from: birthday)
                print("🎂 [RegistroFecha] Edad inicial calculada: \(initialAge)")
            }
            
            // Debug del estado actual
            dataManager.inputData.debugCurrentState()
        }
    }
    
    // Función para calcular la edad basada en la fecha de nacimiento
    private func calculateAge(from birthDate: Date) -> Int {
        print("🧮 [RegistroFecha] Calculando edad desde: \(birthDate)")
        
        let calendar = Calendar.current
        let now = Date()
        
        // Más debugging
        print("🧮 [RegistroFecha] Fecha actual: \(now)")
        
        let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
        
        if let age = ageComponents.year {
            print("✅ [RegistroFecha] Edad calculada correctamente: \(age)")
            
            // Validar que la edad sea razonable
            if age < 0 {
                print("⚠️ [RegistroFecha] Edad negativa detectada - fecha en el futuro")
                dataManager.updateAge(0)
                return 0
            } else if age > 120 {
                print("⚠️ [RegistroFecha] Edad muy alta detectada: \(age)")
                dataManager.updateAge(age) // Aún así guardamos el valor
                return age
            } else {
                dataManager.updateAge(age)
                print("🎯 [RegistroFecha] Edad actualizada en dataManager: \(age)")
                return age
            }
        } else {
            print("❌ [RegistroFecha] Error calculando edad - usando valor por defecto")
            dataManager.updateAge(18) // Valor por defecto más realista
            return 18
        }
    }
    
    // Función adicional para debugging
    private func debugCurrentState() {
        print("🐛 [RegistroFecha] Estado actual completo:")
        print("🐛 [RegistroFecha] birthday (State): \(birthday)")
        print("🐛 [RegistroFecha] dataManager.inputData.Age: \(dataManager.inputData.Age?.description ?? "nil")")
        print("🐛 [RegistroFecha] Diferencia en años: \(Calendar.current.dateComponents([.year], from: birthday, to: Date()).year ?? -1)")
    }
}

#Preview {
    RegistroFechaView()
}
