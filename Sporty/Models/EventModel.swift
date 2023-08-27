//
//  EventModel.swift
//  Sporty
//
//  Created by Smaro Goulianou on 26/8/23.
//

import Foundation

struct Event: Codable {
    let eventID: String
    let sportID: String
    let eventName: String
    let startTime: Int
    var isFavourite: Bool = false
    
    
    enum CodingKeys: String, CodingKey {
        case eventID = "i"
        case sportID = "si"
        case eventName = "d"
        case startTime = "tt"
    }
}
