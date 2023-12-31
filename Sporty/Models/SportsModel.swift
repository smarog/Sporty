//
//  SportsModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

struct Sports: Codable {
    let sportID: String
    let sportName: String
    var events: [Event]
    var isExpanded: Bool = false

    enum CodingKeys: String, CodingKey {
        case sportID = "i"
        case sportName = "d"
        case events = "e"
    }
}
