//
//  Card.swift
//  DeckOfOne
//
//  Created by Caston  Boyd on 5/21/18.
//  Copyright © 2018 Caston  Boyd. All rights reserved.
//

import UIKit

struct Cards: Codable {
    var cards: [Card]
}

struct Card: Codable {
    var image: String
    var code: String
    var value: String
    var suit: String
}
