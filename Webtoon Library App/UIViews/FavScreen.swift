//
//  FavScreen.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import Foundation
import SwiftUI

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: WebtoonViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.favoriteWebtoons.isEmpty {
                Text("No favorites yet.")
                    .foregroundColor(.gray)
            } else {
                List(viewModel.favoriteWebtoons) { webtoon in
                    NavigationLink(destination: DetailView(webtoon: webtoon, viewModel: viewModel, isFromFavorites: true)) { // Pass true for favorites
                        HStack {
                            Image(webtoon.thumbnail)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                            Text(webtoon.title)
                        }
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
