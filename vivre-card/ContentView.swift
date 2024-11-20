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
    
    @State private var showAddVivreCardSheet = false
    
    //VivreCardView(targetLatitude: 37.7749, targetLongitude: -122.419)
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vivreCards) { vivreCard in
                    NavigationLink {
                        VivreCardView(targetLatitude: vivreCard.latitude,
                                      targetLongitude: vivreCard.longitude)
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
                    Button {
                        showAddVivreCardSheet.toggle()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                    .sheet(isPresented: $showAddVivreCardSheet){
                        AddVivreCardView()
                    }
                }
            }
            .navigationTitle("Vivre Cards")
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
