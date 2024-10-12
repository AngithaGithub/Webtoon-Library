//
//  HomeScreen.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import SwiftUI

struct HomeView: View {
    var webtoons = webtoonCategories
    @ObservedObject var viewModel: WebtoonViewModel
    
    var body: some View {
        NavigationView {
            List(webtoons) { webtoon in
                NavigationLink(destination: DetailView(webtoon: webtoon, viewModel: viewModel, isFromFavorites: false)) { // Pass false for non-favorites
                    HStack {
                        Image(webtoon.thumbnail)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                        Text(webtoon.title)
                    }
                }
            }
            .navigationTitle("Webtoon Library")
        }
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}


