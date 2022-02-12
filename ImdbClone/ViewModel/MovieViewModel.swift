//
//  MovieViewModel.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 11/02/22.
//

import Foundation

enum ViewModelState:Int {
    case loadingData = 0
    case dataLoaded
    case empty
}

class MoviewViewModel {
    
    let networkManager: NetworkManager
    
    var results: [MovieItem] = [] {
        
        didSet {
            
            self.state = self.results.isEmpty ? .empty : .dataLoaded
            reloadCollectionView?()
        }
    }
    var pageNumber:Int = 1
    var query:String = ""
    var state:ViewModelState = .empty
    var reloadCollectionView: (() -> Void)?

    init(networkManager: NetworkManager) {

        self.networkManager = networkManager
    }
    
    func fetchSearchResults(loadMore:Bool = false) {
        
//        print(#function)
        
        self.state = .loadingData
        networkManager.getSearchResults(query: self.query, endpoint: .search, page: loadMore ? pageNumber : self.pageNumber ) { (data, error) in
            
            if let resultData = data {

                if !loadMore
                {
                    self.results = resultData
                }
                else
                {
                    self.results.append(contentsOf: resultData)
                }
            }
        }
    }
    
}
