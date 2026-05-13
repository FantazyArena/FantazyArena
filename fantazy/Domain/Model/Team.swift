class Player{
    let name: String
    let number: String
    let position: String
    let image: String
    
    init(name: String, number: String, position: String, image: String) {
        self.image = image
        self.name = name
        self.position = position
        self.number = number
    }
}

class Team{
    let thumbnail: String?
    let name: String
    let coach: String
    let players: [Player]
    
    init(
        thumbnail: String,
        name: String,
        coach: String,
        players: [Player]
    ){
        self.thumbnail = thumbnail
        self.name = name
        self.players = players
        self.coach = coach
    }
}
