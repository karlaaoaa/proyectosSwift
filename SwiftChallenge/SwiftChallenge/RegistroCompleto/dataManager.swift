import Foundation
import Combine
import UIKit
import SwiftUI

@MainActor
class MLDataManager: ObservableObject {
    static let shared = MLDataManager()
    
    @Published var inputData = InputData()
    @Published var isLoading = false
    @Published var lastPrediction: MLResponse?
    @Published var errorMessage: String?
    @State private var predictionResult: MLResponse? = nil
    
    private let apiURL = "https://diabetes-clustering.onrender.com/predict"
    
    private init() {}
    
    // Update specific fields from different views
    func updateHighBP(_ value: Bool) {
        inputData.HighBP = value
        clearPreviousResults()
    }
    
    func updateHighChol(_ value: Bool) {
        inputData.HighChol = value
        clearPreviousResults()
    }
    
    func updateGenHlth(_ value: Int) {
        inputData.GenHlth = value
        clearPreviousResults()
    }
    
    func updateSex(_ value: Int) {
        inputData.Sex = value
        clearPreviousResults()
    }
    
    func updateDiabetes(_ value: Bool) {
        inputData.Diabetes = value
        clearPreviousResults()
    }
    
    func updateAge(_ value: Int) {
        inputData.Age = value
        clearPreviousResults()
    }
    
    func updateBMI(_ value: Int) {
        inputData.BMI = value
        clearPreviousResults()
    }
    
    private func clearPreviousResults() {
        lastPrediction = nil
        errorMessage = nil
    }
    
    // Reset all data
    func resetData() {
        inputData = InputData()
        lastPrediction = nil
        errorMessage = nil
    }
    
    // Send data to ML model API - Esta función se llama desde el botón
    func predictCluster() async {
        print("🚀 [MLDataManager] Iniciando predicción...")
        
        guard inputData.isComplete() else {
            print("❌ [MLDataManager] Error: Datos incompletos")
            await MainActor.run {
                self.errorMessage = "Please fill all required fields"
            }
            return
        }
        
        print("✅ [MLDataManager] Validación de datos completada")
        
        await MainActor.run {
            self.isLoading = true
            self.errorMessage = nil
        }
        
        // Ejecutar la predicción en un hilo de fondo
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.executePerformPrediction()
            }
        }
    }
    
    // Función que maneja la ejecución en hilo separado
    private func executePerformPrediction() async {
        print("🔄 [MLDataManager] Ejecutando predicción en hilo separado...")
        print("🧵 [MLDataManager] Ejecutando en contexto asíncrono")
        
        do {
            let prediction = try await performPrediction()
            print("🎉 [MLDataManager] Predicción exitosa recibida")
            
            await MainActor.run {
                self.lastPrediction = prediction
                self.isLoading = false
            }
        } catch {
            print("💥 [MLDataManager] Error en predicción: \(error.localizedDescription)")
            
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    private func performPrediction() async throws -> MLResponse {
        print("🌐 [API] Iniciando llamada a API...")
        
        guard let url = URL(string: apiURL) else {
            print("❌ [API] Error: URL inválida - \(apiURL)")
            throw NetworkError.invalidURL
        }
        
        print("✅ [API] URL válida: \(url)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody = inputData.toDictionary()
        print("📤 [API] Datos a enviar:")
        print("📤 [API] \(requestBody)")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            print("✅ [API] Serialización JSON exitosa")
        } catch {
            print("❌ [API] Error en serialización JSON: \(error)")
            throw NetworkError.decodingError
        }
        
        print("🔄 [API] Enviando request...")
        print("🔄 [API] Ejecutando URLSession en contexto asíncrono")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        print("📥 [API] Respuesta recibida")
        
        guard let httpResponse = response as? HTTPURLResponse else {
            print("❌ [API] Error: Respuesta no es HTTPURLResponse")
            throw NetworkError.invalidResponse
        }
        
        print("📊 [API] Status Code: \(httpResponse.statusCode)")
        print("📊 [API] Headers: \(httpResponse.allHeaderFields)")
        
        guard httpResponse.statusCode == 200 else {
            print("❌ [API] Error: Status code no es 200")
            if let responseString = String(data: data, encoding: .utf8) {
                print("❌ [API] Respuesta del servidor: \(responseString)")
            }
            throw NetworkError.invalidResponse
        }
        
        print("✅ [API] Status code 200 - Respuesta exitosa")
        
        // Log de los datos raw recibidos
        if let responseString = String(data: data, encoding: .utf8) {
            print("📥 [API] Datos recibidos (raw): \(responseString)")
        }
        
        do {
            let mlResponse = try JSONDecoder().decode(MLResponse.self, from: data)
            print("✅ [API] Decodificación JSON exitosa")
            print("📊 [API] Respuesta decodificada: \(mlResponse)")
            return mlResponse
        } catch {
            print("❌ [API] Error en decodificación: \(error)")
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decodingError:
            return "Failed to decode response"
        }
    }
}
