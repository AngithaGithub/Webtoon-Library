//
//  Webtoon_Library_AppApp.swift
//  Webtoon Library App
//
//  Created by oem on 11/10/24.
//

import SwiftUI
import SwiftData

@main
struct Webtoon_Library_AppApp: App {
    @StateObject var viewModel = WebtoonViewModel()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView(viewModel: viewModel)  // Pass the ViewModel to HomeView
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                FavoritesView(viewModel: viewModel)  // Pass the same ViewModel to FavoritesView
                    .tabItem {
                        Label("Favorites", systemImage: "star.fill")
                    }
            }
        }
    }
}
