//
//  vivre_cardApp.swift
//  vivre-card
//
//  Created by Rafael Badaró on 08/11/24.
//

import SwiftUI
import SwiftData

@main
struct vivre_cardApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            VivreCard.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
