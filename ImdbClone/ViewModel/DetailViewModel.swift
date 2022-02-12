//
//  File.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 12/02/22.
//

import Foundation

class DetailViewModel {
    
//    let networkManager: NetworkManager
    var detail: MovieItem = MovieItem() {
        
        didSet{
            
            reloadTableView?()
        }
    }
        
    var reloadTableView: (() -> Void)?

    init(item:MovieItem) {

        self.detail = item
    }
    
    func doSomethingBackendRelated(id:String) {
        
        // we can call post request here, for example add item to favourites
    }
}
