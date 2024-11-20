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
    
    var isBtnSaveDisabled: Bool {
        return name.isEmpty || latitude.isNaN || longitude.isNaN
    }
    // TODO: fazer o dismiss do keyboard no click ou scroll na tela (add isso na edit view)
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Fill Vivre Card info")
                    .font(.largeTitle)
                    .bold()
                
                VStack {
                    Text("Name:")
                    TextField("Name",
                              text: $name)
                    .keyboardType(.default)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.primary, lineWidth: 1.5)
                    )
                }.padding()
                
                VStack {
                    Text("Latitude:")
                    TextField("Latitude",
                              value: $latitude,
                              formatter: numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
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
                              formatter: numberFormatter)
                    .keyboardType(.numbersAndPunctuation)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.primary, lineWidth: 1.5)
                    )
                }.padding()
                
                //TODO: criar opcoes aqui: manually add, atraves de um link, etc
                Button (action: addItem) {
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
    }
    
    private func addItem() {
        withAnimation {
            let newItem = VivreCard(name: self.name,
                                    latitude: self.latitude,
                                    longitude: self.longitude,
                                    createdAt: Date(),
                                    updatedAt: Date())
            modelContext.insert(newItem)
            dismiss()
        }
    }
    
}

#Preview {
    AddVivreCardView()
}
