//
//  WebtoonModel.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import Foundation

//struct WebtoonCategory: Codable {
//    let title: String
//    let thumbnail: String
////    var id = UUID()
////    let description: String
////    let rating: Double
//}
//
//struct WebtoonDetail: Codable {
//    let title: String
//    let description: String
//    let imageUrl: String
//}

//import Foundation
struct Webtoon: Identifiable, Codable, Equatable {
    let id: String  // Use a string or integer that uniquely identifies the webtoon
    let title: String
    let thumbnail: String
    let description: String
    var rating: Double = 0.0
}

let webtoonCategories: [Webtoon] = [
    Webtoon(id: "1", title: "Hello Baby", thumbnail: "image1", description: "Gwen is a kind and passionate young woman with a tragic backstory. Her mother died when she was young, and her stepmother and stepsister treated her even worse with the demise of her father. Before dying, her father suggests she go on a cruise vacation with her best friend when her partner broke up with her to focus on his career instead. On the vacation, she meets Arthur, a handsome but lonely young man. Things escalate between them when they share their unfortunate fates. They end up hooking up, but Gwen runs away, afraid of the outcome. Fate brings them 2 years later, and they end up in a legal fight when Arthur finds out about his and Gwen’s child. Read Hello Baby to learn whether they can solve their differences.", rating: 0),
    Webtoon(id: "2", title: "The Alpha King’s Claim", thumbnail: "image2", description: "Do you believe in supernatural creatures like werewolves, vampires, and witches? How would you feel if one day you were transported to a different realm when you touched a painting? The same thing happened with Serena in The Alpha King’s Claim. One rainy day, she buys an interesting painting while taking shelter in a painting shop. When she touched the painting at her home, she got transported to the realm where werewolves lived. Moreover, she ends up on the bed of the Alpha King Aero, who hates all women.", rating: 0),
    Webtoon(id: "3", title: "Bitten Contract", thumbnail: "image3", description: "Do you believe vampires exist? What would your first reaction be if you crossed paths with a vampire? Would you be delighted, terrified, or unsure of how to act? Well, Chae-i certainly had an unusual reaction than the others. Chae-i is an actress who has been in the entertainment industry ever since she can remember. However, she is been having a hard time fitting in with other actors due to the extremely painful headaches she started having a little while ago. As a consequence of this, her professional life started deteriorating.", rating: 00),
    // Add more categories
]

import Foundation

class WebtoonViewModel: ObservableObject {
    @Published var favoriteWebtoons: [Webtoon] = []
    
    func addToFavorites(webtoon: Webtoon) {
        if !favoriteWebtoons.contains(where: { $0.id == webtoon.id }) {
            favoriteWebtoons.append(webtoon)
            saveFavorites()
        }
    }
    
    func updateRating(for webtoon: Webtoon, with rating: Double) {
        // Update the rating for the webtoon in the favorites list if it exists
        if let index = favoriteWebtoons.firstIndex(where: { $0.id == webtoon.id }) {
            favoriteWebtoons[index].rating = rating
            saveFavorites()
        }
    }
    
    func getRating(for webtoon: Webtoon) -> Double {
        // Return the saved rating if the webtoon is in the favorites list
        if let savedWebtoon = favoriteWebtoons.first(where: { $0.id == webtoon.id }) {
            return savedWebtoon.rating
        }
        return webtoon.rating  // Return default rating if not in favorites
    }
    
    func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favoriteWebtoons) {
            UserDefaults.standard.set(encoded, forKey: "favorites")
        }
    }
    
    func loadFavorites() {
        if let savedData = UserDefaults.standard.data(forKey: "favorites"),
           let decoded = try? JSONDecoder().decode([Webtoon].self, from: savedData) {
            favoriteWebtoons = decoded
        }
    }
}
