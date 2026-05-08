//
//  League.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

struct League {

    let name : String?
    let badgeURL : String?
    
    init(name:String,badgeURL:String){
        self.name = name
        self.badgeURL = badgeURL
    }
}


class Sport{
    let name: String
    let thumbnail: String
    
    init(name: String, thumbnail: String) {
        self.name = name
        self.thumbnail = thumbnail
    }
}
