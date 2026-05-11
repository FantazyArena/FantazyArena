//
//  Team.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 09/05/2026.
//

import Foundation

struct Team {
    let id: String
    let name: String
    let badgeURL: String?
    let posterURL: String?
    let foundedYear: String?
    let stadiumName: String?
    let description: String?
    let socialLinks: SocialLinks
    let members: [TeamMember]
}

struct SocialLinks {
    let website: String?
    let twitter: String?
    let instagram: String?
    let youtube: String?
}

struct TeamMember {
    let name: String
    let role: String?
    let imageURL: URL?
}
