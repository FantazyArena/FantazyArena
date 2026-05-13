class TeamDetails{
    let thumbnail: String?
    let name: String
    let founded: String
    let national: String
    let players: [Player]
    
    init(
        thumbnail: String,
        name: String,
        founded: String,
        national: String,
        players: [Player]
    ){
        self.thumbnail = thumbnail
        self.name = name
        self.founded = founded
        self.national = national
        self.players = players
    }
}
