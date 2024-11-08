//
//  Item.swift
//  vivre-card
//
//  Created by Rafael Badaró on 08/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
