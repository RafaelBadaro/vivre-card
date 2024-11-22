//
//  Item.swift
//  vivre-card
//
//  Created by Rafael Badaró on 08/11/24.
//

import Foundation
import SwiftData

@Model
final class VivreCard {
    var name: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date
    var updatedAt: Date
    
    init(name: String,
         latitude: Double,
         longitude: Double,
         createdAt: Date = Date(),
         updatedAt: Date = Date()) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
