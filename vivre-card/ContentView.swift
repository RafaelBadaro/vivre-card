//
//  ContentView.swift
//  vivre-card
//
//  Created by Rafael Badaró on 08/11/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var vivreCards: [VivreCard]
    
    //    VivreCardView(targetLatitude: -23.626578, targetLongitude: -46.659628)
    
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(vivreCards) { vivreCard in
                    NavigationLink {
                        VivreCardView(targetLatitude: vivreCard.latitude,
                                      targetLongitude: vivreCard.latitude)
                        .navigationTitle(vivreCard.name)
                    } label: {
                        Text(vivreCard.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = VivreCard(name: "San francisco",
                               latitude: 37.7749,
                               longitude: -122.4194,
                               createdAt: Date(),
                               editedAt: Date())
            modelContext.insert(newItem)
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(vivreCards[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: VivreCard.self, inMemory: true)
}
