//
//  Event.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import Foundation

struct Event {
    let id: String
    let homeTeam: Team
    let awayTeam: Team
    let date: String
    let time: String
    let stadium: String?
    let league: String?
    let status: EventStatus
}

enum EventStatus {
    case upcoming
    case live
    case finished
}
