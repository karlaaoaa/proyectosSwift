//
//  FlashcardViewModel.swift
//  myFirstApp
//
//  Created by Alumno on 07/06/25.
//

import Foundation

class FlashcardViewModel: ObservableObject {
    @Published var cards: [Flashcard] = [
        Flashcard(term: "Llamada", definition: "Call"),
        Flashcard(term: "Escuela", definition: "School"),
        Flashcard(term: "Restaurante", definition: "Restaurant"),
        Flashcard(term: "Hola", definition: "Hello"),
        Flashcard(term: "Silla", definition: "Chair"),
    ]
    
    @Published var currentIndex = 0
    @Published var showAnswer = false
    
    var currentCard: Flashcard {
        cards[currentIndex]
    }
    
    //una funcion que muestra el  siguiente index
    func nextCard() {
        currentIndex = currentIndex + 1
        showAnswer = false
    }
    
    func revealAnswer() {
        showAnswer.toggle()
    }
}
