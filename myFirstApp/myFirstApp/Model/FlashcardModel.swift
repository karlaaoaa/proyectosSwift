//
//  FlashcardModel.swift
//  myFirstApp
//
//  Created by Alumno on 07/06/25.
//

import Foundation

//el modelo de una flashcard
struct Flashcard: Identifiable {
    let id = UUID()
    let term: String
    let definition: String
}
