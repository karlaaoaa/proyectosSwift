import SwiftUI

struct ErrorClusterView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(0.2), Color.white]),
                startPoint: .top,
                endPoint: .center
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Error al obtener tu perfil")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)

                Text("Ocurrió un problema al conectar con el servidor.\nPor favor, intenta nuevamente.")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: {
                    dismiss()
                }) {
                    Text("Volver")
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                        .cornerRadius(10)
                        .padding(.horizontal, 80)
                }
            }
            .padding()
        }
    }
}

