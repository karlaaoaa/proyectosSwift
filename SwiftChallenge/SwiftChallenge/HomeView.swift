import SwiftUI

struct HomeView: View {
    // Variables de estado para datos del usuario
    @State private var userName: String = "María"
    @State private var currentGlucose: Int = 150
    @State private var lastMealTime: String = "hace 2 horas"
    let cluster: Int
    
    // Función para determinar el cluster basado en BMI
    private func getUserCluster() -> (emoji: String, name: String, description: String, color: Color) {
        switch cluster {
        case 0:
            return (
                emoji: "💚",
                name: "Activo Balanceado",
                description: "Tienes hábitos saludables muy buenos. Tu objetivo es mantener esta estabilidad.",
                color: .green
            )
        case 3:
            return (
                emoji: "💛",
                name: "Bienestar en Progreso",
                description: "Vas por buen camino. Vamos a mejorar tu energía con mejores elecciones.",
                color: .yellow
            )
        case 4:
            return (
                emoji: "🧡",
                name: "Camino Saludable",
                description: "Pequeños cambios pueden hacer una gran diferencia en tu glucosa.",
                color: .orange
            )
        case 1:
            return (
                emoji: "💙",
                name: "Enfoque Vital",
                description: "Vamos a cuidar juntos el orden de tus comidas paso a paso.",
                color: .blue
            )
        default:
            return (
                emoji: "💜",
                name: "Cuidado Personal",
                description: "Estoy aquí para ayudarte a tomar mejores decisiones cada día.",
                color: .purple
            )
        }
    }
    private func getGlucoseStatus() -> (String, Color, String) {
        switch currentGlucose {
        case ..<70:
            return ("BAJA", .red, "exclamationmark.triangle.fill")
        case 70..<100:
            return ("NORMAL", .green, "checkmark.circle.fill")
        case 100..<140:
            return ("NORMAL", .green, "checkmark.circle.fill")
        case 140..<200:
            return ("ALTA", .orange, "exclamationmark.triangle.fill")
        default:
            return ("MUY ALTA", .red, "exclamationmark.triangle.fill")
        }
    }
    
    // Recomendaciones basadas en cluster y glucosa
    private func getClusterRecommendations() -> [String] {
        let cluster = getUserCluster()
        
        // Si la glucosa está fuera de rango, priorizar eso
        if currentGlucose < 70 {
            return [
                "🍯 Come algo dulce ahora",
                "🥤 Bebe jugo de naranja",
                "🍌 Come una fruta"
            ]
        } else if currentGlucose > 140 {
            return [
                "🥗 Come verduras",
                "🚶‍♀️ Camina un poco",
                "💧 Toma agua"
            ]
        }
        
        // Recomendaciones según cluster
        switch cluster.name {
        case "Activo Balanceado":
            return [
                "🐟 Pescado con verduras",
                "🥗 Ensalada fresca",
                "🍎 Fruta de temporada"
            ]
        case "Bienestar en Progreso":
            return [
                "🥪 Sandwich integral",
                "🥛 Yogurt natural",
                "🥕 Verduras al vapor"
            ]
        case "Camino Saludable":
            return [
                "🍳 Huevo con verduras",
                "🍗 Pollo a la plancha",
                "🥒 Ensalada simple"
            ]
        case "Enfoque Vital":
            return [
                "🍲 Sopa de verduras",
                "🧀 Queso bajo en grasa",
                "🥬 Verduras cocidas"
            ]
        default: // Cuidado Personal
            return [
                "🥣 Avena con fruta",
                "🍵 Té con galletas integrales",
                "🥛 Leche descremada"
            ]
        }
    }
    
    var body: some View {
        ZStack {
            // Fondo más suave
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                           startPoint: .top, endPoint: .center)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 30) {
                    // Saludo simple y grande
                    VStack(spacing: 10) {
                        Text("Hola \(userName)")
                            .font(.system(size: 32, weight: .medium))
                            .foregroundColor(.primary)
                        
                        Text("¿Cómo está tu glucosa hoy?")
                            .font(.system(size: 18))
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 20)
                    
                    // Tarjeta de glucosa - MUY GRANDE Y SIMPLE
                    VStack(spacing: 20) {
                        Text("Tu Glucosa")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        // Número de glucosa muy grande
                        HStack {
                            Spacer()
                            VStack(spacing: 8) {
                                Text("\(currentGlucose)")
                                    .font(.system(size: 72, weight: .bold))
                                    .foregroundColor(getGlucoseStatus().1)
                                
                                Text("mg/dL")
                                    .font(.system(size: 20))
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        
                        // Estado con icono grande
                        HStack(spacing: 12) {
                            Image(systemName: getGlucoseStatus().2)
                                .font(.system(size: 30))
                                .foregroundColor(getGlucoseStatus().1)
                            
                            Text(getGlucoseStatus().0)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(getGlucoseStatus().1)
                        }
                        
                        Text("Última comida: \(lastMealTime)")
                            .font(.system(size: 16))
                            .foregroundColor(.secondary)
                    }
                    .padding(30)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    // Tarjeta del perfil del usuario
                    VStack(spacing: 15) {
                        HStack {
                            Text(getUserCluster().emoji)
                                .font(.system(size: 40))
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Tu perfil es:")
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                
                                Text(getUserCluster().name)
                                    .font(.system(size: 22, weight: .bold))
                                    .foregroundColor(getUserCluster().color)
                            }
                            Spacer()
                        }
                        
                        Text(getUserCluster().description)
                            .font(.system(size: 18))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                    }
                    .padding(25)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .gray.opacity(0.2), radius: 10, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    
                    // Recomendaciones muy simples
                    VStack(spacing: 20) {
                        Text("¿Qué puedes comer?")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        VStack(spacing: 15) {
                            ForEach(getClusterRecommendations(), id: \.self) { recommendation in
                                HStack {
                                    Text(recommendation)
                                        .font(.system(size: 20))
                                        .foregroundColor(.primary)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                .padding(.vertical, 15)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 2)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    // Botón GRANDE para agregar comida
                    Button(action: {
                        // Navegación a agregar comida
                        print("Ir a agregar comida...")
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 30))
                            
                            Text("AGREGAR COMIDA")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 25)
                        .background(
                            Color(red: 0.2, green: 0.7, blue: 0.3)
                        )
                        .cornerRadius(20)
                        .shadow(color: .green.opacity(0.4), radius: 10, x: 0, y: 5)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

// Vista de preview
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(cluster: 4)
    }
}

