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
