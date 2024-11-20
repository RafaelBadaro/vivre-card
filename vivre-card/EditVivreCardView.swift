//
//  EditVivreCardView.swift
//  vivre-card
//
//  Created by Rafael Badaró on 19/11/24.
//

import SwiftUI

struct EditVivreCardView: View {
    @Environment(\.dismiss) private var dismiss
    let vivreCard: VivreCard
    
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
    
    init(vivreCard: VivreCard) {
        self.vivreCard = vivreCard
    }
    
    var isBtnUpdateDisabled: Bool {
        name.isEmpty
        || latitude.isNaN
        || longitude.isNaN
        || areFieldsEqual
    }
    
    var areFieldsEqual: Bool {
        name == vivreCard.name
        && latitude == vivreCard.latitude
        && longitude == vivreCard.longitude
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Edit Vivre Card info")
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
                
                Button (action: saveItem) {
                    Text("Save")
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .disabled(isBtnUpdateDisabled)
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
        .onAppear() {
            self.name = vivreCard.name
            self.latitude = vivreCard.latitude
            self.longitude = vivreCard.longitude
        }
    }
    
    private func saveItem() {
        withAnimation {
            vivreCard.name = self.name
            vivreCard.latitude = self.latitude
            vivreCard.longitude = self.longitude
            dismiss()
        }
    }
    
}

//#Preview {
//    EditVivreCardView()
//}
