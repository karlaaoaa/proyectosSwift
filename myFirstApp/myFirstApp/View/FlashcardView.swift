//
//  FlashcardView.swift
//  myFirstApp
//
//  Created by Alumno on 07/06/25.
//

import SwiftUI

struct FlashcardView: View {
    @ObservedObject var viewModel : FlashcardViewModel
    
    var body: some View {
        Text(viewModel.currentCard.term)
            .bold()
            .font(.largeTitle)
            .padding(10)
        if viewModel.showAnswer {
            Text(viewModel.currentCard.definition)
        }
        
        HStack {
            Button("Definition") {
                viewModel.revealAnswer()
            }
            .buttonStyle(.bordered)
            Button {
                viewModel.nextCard()
                
            } label: {
                Text("Next")
                Image(systemName: "arrowshape.right")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(20)
        
        
        
    }
}

#Preview {
    FlashcardView(viewModel: FlashcardViewModel())
}
