import SwiftUI

struct LoadingClusterView: View {
    @StateObject private var dataManager = MLDataManager.shared
    @State private var navigate = false
    @State private var cluster: Int? = nil

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(0.2), Color.white]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    ProgressView("Calculando tu perfil...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .green))
                        .foregroundColor(.black)
                        .font(.title3)
                        .padding()
                }
            }
            .navigationDestination(isPresented: $navigate) {
                if let cluster = cluster {
                    HomeView(cluster: cluster)
                } else {
                    ErrorClusterView()
                }
            }
            .onAppear {
                Task {
                    await dataManager.predictCluster()
                    if let result = dataManager.lastPrediction?.cluster {
                        self.cluster = result
                        self.navigate = true
                    } else {
                        dataManager.errorMessage = "No se pudo obtener el cluster. Intenta de nuevo."
                    }
                }
            }
        }
    }
}
