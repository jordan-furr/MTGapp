//
//  Card.swift
//  MTG
//
//  Created by Jordan Furr on 3/12/20.
//  Copyright © 2020 Jordan Furr. All rights reserved.
//

import Foundation

struct Card: Codable {
    let name: String
    let text: String
    let power: Int
    let toughness: Int
    let imageURL: URL
    let id: String
}
