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
    @Query private var items: [Item]
    
    
    @StateObject private var compassManager = CompassManager()
    
    var body: some View {
        VStack {
            if let _ = compassManager.currentLocation {
                // Rotate the arrow based on the bearing angle towards the target location
                Image(systemName: "arrow.up.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .rotationEffect(Angle(degrees: compassManager.rotationAngle))  // Rotate based on bearing
                    .foregroundColor(.blue)
                
                Text("Magnetic Heading: \(compassManager.heading?.magneticHeading ?? 0.0, specifier: "%.1f")°")
                    .font(.title2)
                Text("Angle to Target: \(compassManager.rotationAngle, specifier: "%.1f")°")
                             .font(.title2)
            } else {
                Text("Fetching location...")
            }
        }
    }
    
    //        NavigationSplitView {
    //            List {
    //                ForEach(items) { item in
    //                    NavigationLink {
    //                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
    //                    } label: {
    //                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
    //                    }
    //                }
    //                .onDelete(perform: deleteItems)
    //            }
    //            .toolbar {
    //                ToolbarItem(placement: .navigationBarTrailing) {
    //                    EditButton()
    //                }
    //                ToolbarItem {
    //                    Button(action: addItem) {
    //                        Label("Add Item", systemImage: "plus")
    //                    }
    //                }
    //            }
    //        } detail: {
    //            Text("Select an item")
    //        }
}

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
// }

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
