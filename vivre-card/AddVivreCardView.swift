//
//  AddVivreCardView.swift
//  vivre-card
//
//  Created by Rafael Badaró on 18/11/24.
//

import SwiftUI

struct AddVivreCardView: View {
    @Environment(\.modelContext) private var modelContext
   
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .padding()
                
                TextField("Latitude", value: $latitude, formatter: numberFormatter)
                    .padding()
                
                TextField("Longitude", value: $longitude, formatter: numberFormatter)
                    .padding()
                
                //TODO: criar opcoes aqui: manually add, atraves de um link, etc
                Button (action: addItem) {
                   
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button(action: addItem) {
//                        Text("Add")
//                    }
//                }
            }
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
}

#Preview {
    AddVivreCardView()
}
