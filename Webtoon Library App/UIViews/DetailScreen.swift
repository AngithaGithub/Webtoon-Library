//
//  DetailScreen.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import Foundation
import SwiftUI

//struct WebtoonDetail: Decodable {
//    let title: String
//    let description: String
//    let imageURL: String
//}
import SwiftUI


import SwiftUI

struct DetailView: View {
    var webtoon: Webtoon
    @ObservedObject var viewModel: WebtoonViewModel
    @State private var rating: Double = 0.0
    var isFromFavorites: Bool  // Flag to control the "Add to Favorites" button
    
    var body: some View {
        VStack(spacing: 20) {
            Image(webtoon.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
            
            Text(webtoon.description)
                .font(.body)
                .padding()
            
            if !isFromFavorites {  // Show "Add to Favorites" only if not coming from favorites
                Button(action: {
                    viewModel.addToFavorites(webtoon: webtoon)
                }) {
                    Text("Add to Favorites")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            VStack {
                Text("Rate this Webtoon")
                Slider(value: $rating, in: 1...5, step: 1)  // The slider to adjust rating
                    .onChange(of: rating) { newRating in
                        viewModel.updateRating(for: webtoon, with: newRating)  
                    }
                Text("\(Int(rating)) Stars")
            }
        }
        .padding()
        .navigationTitle(webtoon.title)
        .onAppear {
            // Load the rating when the view appears
            rating = viewModel.getRating(for: webtoon)
        }
    }
}


