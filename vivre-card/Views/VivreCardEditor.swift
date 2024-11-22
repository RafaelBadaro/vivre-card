//
//  AddVivreCardView.swift
//  vivre-card
//
//  Created by Rafael Badaró on 18/11/24.
//

import SwiftUI

struct VivreCardEditor: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var latitude: Double = 0.0
    @State private var longitude: Double = 0.0
    
    let vivreCard: VivreCard?
    
    private var editorTitle: String {
        vivreCard == nil ? "Add Vivre Card" : "Edit Vivre Card"
    }
        
    var isBtnSaveDisabled: Bool {
        return name.isEmpty
        || latitude.isNaN
        || longitude.isNaN
    }
    
    @FocusState private var focusedField: Field?
    enum Field {
        case first, second, third
    }
    
    var body: some View {
        NavigationStack {
            Form {
                VStack {
                    Text(editorTitle)
                        .font(.largeTitle)
                        .bold()
                    
                    VStack {
                        Text("Name:")
                        TextField("Name",
                                  text: $name)
                        .keyboardType(.default)
                        .focused($focusedField, equals: .first)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.primary, lineWidth: 1.5)
                        )
                    }
                    .padding()
                    
                    VStack {
                        Text("Latitude:")
                        TextField("Latitude",
                                  value: $latitude,
                                  format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($focusedField, equals: .second)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.primary, lineWidth: 1.5)
                        )
                    }.padding()
                    
                    VStack {
                        Text("Longitude:")
                        TextField("Longitude",
                                  value: $longitude,
                                  format: .number)
                        .keyboardType(.numbersAndPunctuation)
                        .focused($focusedField, equals: .third)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.primary, lineWidth: 1.5)
                        )
                    }.padding()
                    
                    //TODO: criar opcoes aqui: manually add, atraves de um link, etc
                    Button (action: save) {
                        Text("Save")
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .disabled(isBtnSaveDisabled)
                }
                .padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .onAppear {
                if let vivreCard {
                    // Edit the incoming vivre card.
                    name = vivreCard.name
                    latitude = vivreCard.latitude
                    longitude = vivreCard.longitude
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { _ in
                        focusedField = nil
                }
            )
        }
    }
    
    private func save() {
        withAnimation {
            if let vivreCard {
                // Edit
                vivreCard.name = self.name
                vivreCard.latitude = self.latitude
                vivreCard.longitude = self.longitude
                vivreCard.updatedAt = Date()
            } else {
                // Add
                let newItem = VivreCard(name: self.name,
                                        latitude: self.latitude,
                                        longitude: self.longitude,
                                        createdAt: Date(),
                                        updatedAt: Date())
                modelContext.insert(newItem)
            }
            dismiss()
        }
    }
    
}

//#Preview {
//    VivreCardEditor()
//}
