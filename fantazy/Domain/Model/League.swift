struct League {
    
    let id: String?
    let name : String?
    let badgeURL : String?
    let countryName: String?
    
    init(id:String, name:String,badgeURL:String, countryName: String){
        self.id = id
        self.name = name
        self.badgeURL = badgeURL
        self.countryName = countryName
    }
}
