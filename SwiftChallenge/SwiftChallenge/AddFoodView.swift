//
//  AddFoodView.swift
//  SwiftChallenge
//
//  Created by Alumno on 08/06/25.
//

import SwiftUI

struct AddFoodView: View {
    // Paleta de colores personalizada
    private let primaryColor = Color(hex: "#2C6975")
    private let secondaryColor = Color(hex: "#68B2A0")
    private let lightGreen = Color(hex: "#CDE0C9")
    private let lightestGreen = Color(hex: "#E0ECDE")
    private let white = Color(hex: "#FFFFFF")
    
    // Estado de la vista
    @State private var foodInput: String = ""
    @State private var currentGlucose: String = ""
    @State private var inputMethod: InputMethod = .manual
    @State private var showingAlert: Bool = false
    @State private var alertType: AlertType = .good
    @State private var showingMealPlan: Bool = false
    @State private var isAnalyzing: Bool = false
    @State private var showingCamera: Bool = false
    
    // Lista de alimentos detectados
    @State private var detectedFoods: [String] = []
    
    // Datos del usuario
    @State private var userName: String = "María"
    
    // Mock data para el meal plan de la comida específica
    @State private var mealRecommendations: [MealRecommendation] = []
    
    enum InputMethod {
        case manual, camera
    }
    
    enum AlertType {
        case good, warning, danger
        
        var color: Color {
            switch self {
            case .good: return Color(hex: "#68B2A0")
            case .warning: return .orange
            case .danger: return .red
            }
        }
        
        var icon: String {
            switch self {
            case .good: return "checkmark.circle.fill"
            case .warning: return "exclamationmark.triangle.fill"
            case .danger: return "xmark.circle.fill"
            }
        }
        
        var title: String {
            switch self {
            case .good: return "¡MUY BIEN!"
            case .warning: return "¡CUIDADO!"
            case .danger: return "¡ALERTA!"
            }
        }
        
        var message: String {
            switch self {
            case .good: return "Esta comida es buena para tu glucosa"
            case .warning: return "Esta comida puede subir un poco tu glucosa"
            case .danger: return "Esta comida puede subir mucho tu glucosa"
            }
        }
    }
    
    struct MealRecommendation {
        let suggestion: String
        let emoji: String
        let reason: String
    }
    
    var body: some View {
        ZStack {
            // Fondo con colores de la paleta
            LinearGradient(
                gradient: Gradient(colors: [lightestGreen, white]),
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    // Título principal
                    VStack(spacing: 10) {
                        Text("¿Qué vas a comer?")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(primaryColor)
                        
                        Text("Dime tu comida y nivel de glucosa")
                            .font(.system(size: 18))
                            .foregroundColor(secondaryColor)
                    }
                    .padding(.top, 20)
                    
                    // Input de glucosa actual
                    VStack(spacing: 15) {
                        Text("Tu glucosa ahora:")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(primaryColor)
                        
                        HStack {
                            TextField("Ej: 120", text: $currentGlucose)
                                .font(.system(size: 24, weight: .bold))
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .padding(15)
                                .background(white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(secondaryColor.opacity(0.5), lineWidth: 2)
                                )
                            
                            Text("mg/dL")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(secondaryColor)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Selector de método de input
                    VStack(spacing: 15) {
                        Text("¿Cómo quieres ingresar tu comida?")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(primaryColor)
                        
                        HStack(spacing: 15) {
                            // Botón manual
                            Button(action: {
                                inputMethod = .manual
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: "keyboard")
                                        .font(.system(size: 30))
                                        .foregroundColor(inputMethod == .manual ? white : secondaryColor)
                                    
                                    Text("ESCRIBIR")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(inputMethod == .manual ? white : secondaryColor)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(
                                    inputMethod == .manual ? secondaryColor : white
                                )
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(secondaryColor, lineWidth: 2)
                                )
                            }
                            
                            // Botón cámara
                            Button(action: {
                                inputMethod = .camera
                                showingCamera = true
                            }) {
                                VStack(spacing: 10) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 30))
                                        .foregroundColor(inputMethod == .camera ? white : secondaryColor)
                                    
                                    Text("FOTO")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(inputMethod == .camera ? white : secondaryColor)
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 20)
                                .background(
                                    inputMethod == .camera ? secondaryColor : white
                                )
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(secondaryColor, lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Input manual de comida
                    if inputMethod == .manual {
                        VStack(spacing: 15) {
                            Text("Escribe cada alimento (separados por coma):")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(primaryColor)
                            
                            TextField("Ej: pollo, arroz, ensalada, agua", text: $foodInput)
                                .font(.system(size: 20))
                                .padding(20)
                                .background(white)
                                .cornerRadius(15)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(secondaryColor.opacity(0.5), lineWidth: 2)
                                )
                            
                            if !foodInput.isEmpty {
                                let foods = foodInput.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Alimentos detectados:")
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(primaryColor)
                                    
                                    FlexibleView(data: foods, spacing: 8, alignment: .leading) { food in
                                        Text(food)
                                            .font(.system(size: 14, weight: .medium))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(lightGreen)
                                            .foregroundColor(primaryColor)
                                            .cornerRadius(20)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Alimentos detectados por cámara
                    if inputMethod == .camera && !detectedFoods.isEmpty {
                        VStack(spacing: 15) {
                            Text("Alimentos detectados en la foto:")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(primaryColor)
                            
                            FlexibleView(data: detectedFoods, spacing: 8, alignment: .leading) { food in
                                Text(food)
                                    .font(.system(size: 16, weight: .medium))
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 8)
                                    .background(lightGreen)
                                    .foregroundColor(primaryColor)
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Botón de analizar
                    Button(action: {
                        analyzeFoodImpact()
                    }) {
                        HStack(spacing: 15) {
                            if isAnalyzing {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: white))
                                    .scaleEffect(1.2)
                            } else {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .font(.system(size: 25))
                            }
                            
                            Text(isAnalyzing ? "ANALIZANDO..." : "ANALIZAR COMIDA")
                                .font(.system(size: 22, weight: .bold))
                        }
                        .foregroundColor(white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            primaryColor.opacity(isAnalyzing ? 0.7 : 1.0)
                        )
                        .cornerRadius(15)
                        .shadow(color: primaryColor.opacity(0.4), radius: 8, x: 0, y: 4)
                    }
                    .disabled(shouldDisableAnalyze() || isAnalyzing)
                    .padding(.horizontal, 20)
                    
                    // Alerta de resultado
                    if showingAlert {
                        VStack(spacing: 20) {
                            HStack {
                                Image(systemName: alertType.icon)
                                    .font(.system(size: 35))
                                    .foregroundColor(alertType.color)
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(alertType.title)
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(alertType.color)
                                    
                                    Text(alertType.message)
                                        .font(.system(size: 18))
                                        .foregroundColor(primaryColor)
                                }
                                Spacer()
                            }
                            
                            if alertType == .danger {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("Recomendación:")
                                        .font(.system(size: 18, weight: .semibold))
                                        .foregroundColor(primaryColor)
                                    
                                    Text("• Come una porción más pequeña\n• Acompáñala con verduras\n• Camina después de comer")
                                        .font(.system(size: 16))
                                        .foregroundColor(secondaryColor)
                                }
                            }
                        }
                        .padding(25)
                        .background(alertType.color.opacity(0.1))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(alertType.color.opacity(0.3), lineWidth: 2)
                        )
                        .padding(.horizontal, 20)
                    }
                    
                    // Recomendaciones para esta comida
                    if showingMealPlan && !mealRecommendations.isEmpty {
                        VStack(spacing: 20) {
                            Text("Recomendaciones para esta comida")
                                .font(.system(size: 22, weight: .bold))
                                .foregroundColor(primaryColor)
                            
                            VStack(spacing: 12) {
                                ForEach(Array(mealRecommendations.enumerated()), id: \.offset) { index, recommendation in
                                    HStack(spacing: 15) {
                                        Text(recommendation.emoji)
                                            .font(.system(size: 35))
                                        
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(recommendation.suggestion)
                                                .font(.system(size: 18, weight: .semibold))
                                                .foregroundColor(primaryColor)
                                            
                                            Text(recommendation.reason)
                                                .font(.system(size: 16))
                                                .foregroundColor(secondaryColor)
                                                .multilineTextAlignment(.leading)
                                        }
                                        
                                        Spacer()
                                    }
                                    .padding(20)
                                    .background(white)
                                    .cornerRadius(15)
                                    .shadow(color: primaryColor.opacity(0.1), radius: 5, x: 0, y: 2)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Botón para volver al inicio
                    if showingMealPlan {
                        Button(action: {
                            print("Volver al inicio...")
                        }) {
                            HStack(spacing: 15) {
                                Image(systemName: "house.fill")
                                    .font(.system(size: 25))
                                
                                Text("VOLVER AL INICIO")
                                    .font(.system(size: 22, weight: .bold))
                            }
                            .foregroundColor(white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 20)
                            .background(secondaryColor)
                            .cornerRadius(15)
                            .shadow(color: secondaryColor.opacity(0.4), radius: 8, x: 0, y: 4)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 30)
                    }
                }
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraView(detectedFoods: $detectedFoods)
        }
    }
    
    // Función para verificar si el botón debe estar deshabilitado
    private func shouldDisableAnalyze() -> Bool {
        let hasFood = inputMethod == .manual ? !foodInput.isEmpty : !detectedFoods.isEmpty
        let hasGlucose = !currentGlucose.isEmpty
        return !hasFood || !hasGlucose
    }
    
    // Función para analizar el impacto de la comida
    private func analyzeFoodImpact() {
        isAnalyzing = true
        
        let foods = inputMethod == .manual ?
            foodInput.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespaces) } :
            detectedFoods
        
        let glucose = Int(currentGlucose) ?? 120
        
        // Simular llamada a API/ML (reemplaza con tu lógica real)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Aquí irá tu lógica real de análisis
            let hasHighGlycemicFood = foods.contains { food in
                let lowercased = food.lowercased()
                return lowercased.contains("pizza") || lowercased.contains("dulce") ||
                       lowercased.contains("refresco") || lowercased.contains("pan blanco")
            }
            
            let hasMediumGlycemicFood = foods.contains { food in
                let lowercased = food.lowercased()
                return lowercased.contains("arroz") || lowercased.contains("pasta") ||
                       lowercased.contains("papa")
            }
            
            if hasHighGlycemicFood || glucose > 140 {
                alertType = .danger
            } else if hasMediumGlycemicFood || glucose > 100 {
                alertType = .warning
            } else {
                alertType = .good
            }
            
            isAnalyzing = false
            showingAlert = true
            
            // Generar recomendaciones específicas para esta comida
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                generateMealRecommendations(for: foods, glucose: glucose)
            }
        }
    }
    
    // Función para generar recomendaciones específicas para la comida
    private func generateMealRecommendations(for foods: [String], glucose: Int) {
        // Mock data - reemplaza con tu llamada real a ML/API
        mealRecommendations = [
            MealRecommendation(
                suggestion: "Agregar fibra",
                emoji: "🥗",
                reason: "Las verduras ayudan a controlar la absorción de glucosa"
            ),
            MealRecommendation(
                suggestion: "Tomar agua",
                emoji: "💧",
                reason: "Mantente hidratado para mejor control de glucosa"
            ),
            MealRecommendation(
                suggestion: "Porción moderada",
                emoji: "🍽️",
                reason: "Controla las cantidades para evitar picos de glucosa"
            )
        ]
        
        showingMealPlan = true
    }
}

// Vista simulada de cámara
struct CameraView: View {
    @Binding var detectedFoods: [String]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Simulador de Cámara")
                .font(.title)
                .fontWeight(.bold)
            
            Text("En la app real, aquí estaría la cámara")
                .font(.body)
                .foregroundColor(.secondary)
            
            // Simular detección de alimentos
            Button("Simular detección") {
                detectedFoods = ["Pollo", "Arroz", "Brócoli", "Agua"]
                presentationMode.wrappedValue.dismiss()
            }
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

// Vista flexible para mostrar elementos en filas
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(Array(data.chunked(into: 3)), id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row, id: \.self) { item in
                        content(item)
                    }
                    Spacer()
                }
            }
        }
    }
}

// Extensión para dividir arrays en chunks
extension Collection {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[index(startIndex, offsetBy: $0)..<index(startIndex, offsetBy: Swift.min($0 + size, count))])
        }
    }
}

// Extensión para colores hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Vista de preview
struct AddFoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodView()
    }
}

