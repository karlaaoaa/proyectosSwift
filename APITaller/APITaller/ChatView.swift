//
//  ChatView.swift
//  APITaller
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let content: AttributedString
    let isUser: Bool
}

struct ChatView: View {
    @State var messages: [Message] = []
    @State var newMessage: String = ""
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10){
                ForEach(messages){ msg in
                    HStack{
                        if msg.isUser {
                            Spacer()
                        }
                        Text(msg.content)
                            .padding()
                            .background(msg.isUser ? .blue : .gray.opacity(0.2)) //si es usuario el color es azul else es gris
                            .foregroundColor(msg.isUser ? .white : .black)
                            .cornerRadius(12)
                        
                        if !msg.isUser {
                            Spacer()
                        }
                    }
                }
                .padding()
            }
        }
        
        HStack(spacing: 10) {
            TextField("Escribe un mensaje...", text: $newMessage)
                .padding(12)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            Button(action: sendMessage) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Image(systemName: "paperplane.fill")
                        .foregroundStyle(.white)
                }
            }
            .padding(12)
            .background((newMessage.isEmpty || isLoading) ? Color.gray : Color.blue)
            .cornerRadius(12)
            .disabled(newMessage.isEmpty || isLoading)
        }
        .padding()
        .onAppear {
            let intro = try? AttributedString(markdown: "Hola soy **Kiwi** 🥝 Preguntame lo que quieras")
            messages.append(Message(content: intro ?? AttributedString("Hola preguntame lo que quieras"), isUser: false))
        }
    }
    
    func sendMessage() {
        messages.append(Message(content: AttributedString(newMessage), isUser: true))
        let input = newMessage
        newMessage = ""
        isLoading = true
        
        Task {
            do {
                let reply = try await getGeminiReply(for: input)
                let formatted = try AttributedString(markdown: reply)
                messages.append(Message(content: formatted, isUser: false))
            } catch {
                messages.append(Message(content: AttributedString("Error: \(error.localizedDescription)"), isUser: false))
            }
            isLoading = false
        }
    }
    
    func getGeminiReply (for text: String) async throws -> String {
        let apiKey = "AIzaSyCBwoeVWkVNsY3uI11opktTdCA-AUO3JqQ"
        let url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=\(apiKey)")!
        
        let body: [String : Any] = [
            "system_instruction": [
                "parts": [["text": "Eres un bot que da respuestas super concisas y amigables. Usa muchos emojis. Conesta como ni"]]
            ],
            "contents": [
                ["parts": [["text": text]]]
            ]
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        
        let(data, _) = try await URLSession.shared.data(for: request)
        
        let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        let reply = (((json?["candidates"] as? [[String: Any]])?.first)?["content"] as? [String: Any])?["parts"] as? [[String: Any]]
        return reply?.first?["text"] as? String ?? ""
    }
}

#Preview {
    ChatView()
}
