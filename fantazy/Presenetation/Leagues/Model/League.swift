//
//  League.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

struct League {

    let name : String?
    let badgeURL : String?
    let countryName: String?
    
    init(name:String,badgeURL:String, countryName: String){
        self.name = name
        self.badgeURL = badgeURL
        self.countryName = countryName
    }
}
