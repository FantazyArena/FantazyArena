//
//  LeaguesProtocols.swift
//  fantazy
//
//  Created by Ahmed El Sayyad Mohamed on 07/05/2026.
//

protocol LeaguesPresenterProtocol {
    
    func viewDidLoad()
    
    func getSportName()-> String
    func getLeaguesCount()-> Int
    func getLeague(at index:Int)-> League
    
    func didSelectLeague(at index:Int)
}

protocol LeaguesViewProtocol: AnyObject {
    
    func reloadData()
    
    func showLoading()
    func hideLoading()
    
    func showEmpty()
    func showError(message:String)
}
