import SwiftUI

struct RegistroPAView: View {
    @State private var peso = 70
    @State private var estatura = 170
    @StateObject private var dataManager = MLDataManager.shared

    let limitePeso = Array(30...250)
    let limiteEstatura = Array(100...220)

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.804, green: 0.878, blue: 0.788).opacity(20), Color.white]),
                               startPoint: .top, endPoint: .center)
                .ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("Selecciona tu peso y estatura")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(20)
                        .multilineTextAlignment(.center)

                    Picker("Peso", selection: $peso) {
                        ForEach(limitePeso, id: \.self) { peso_ in
                            Text("\(peso_) kg")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                    .clipped()

                    Divider().padding(.vertical)

                    Picker("Estatura", selection: $estatura) {
                        ForEach(limiteEstatura, id: \.self) { estatura_ in
                            Text("\(estatura_) cm")
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 100)
                    .clipped()

                    NavigationLink(
                        destination: RegistroCPView(),
                        label: {
                            Text("Siguiente")
                                .foregroundColor(.black)
                                .fontWeight(.none)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color(red: 0.6, green: 0.8, blue: 0.65).opacity(0.6))
                                .cornerRadius(10)
                                .padding(.horizontal, 60)
                                .padding(25)
                        }
                        
                    )
                    .buttonStyle(.plain) // Fucking heellslslslsllsls
                    .simultaneousGesture(TapGesture().onEnded {
                        calculateBMI(peso: Double(peso), estaturaCM: Double(estatura))
                    })
                }
                .padding(.horizontal, 36)
            }
        }
    }

    // ✅ Función fuera del body
    public func calculateBMI(peso: Double, estaturaCM: Double) {
        let estaturaM = estaturaCM / 100
        let BMI = Int(peso / (estaturaM * estaturaM))
        dataManager.updateBMI(BMI)
        print("Valor de BMI actualizado a:", BMI)
    }
}

#Preview {
    RegistroPAView()
}
