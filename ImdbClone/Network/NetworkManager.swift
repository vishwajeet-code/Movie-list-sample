//
//  NetworkManager.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 11/02/22.
//

import Foundation
import Alamofire

enum HTTPMethod: String {

    case get     = "GET"
    case post    = "POST"
}

enum APIError: String {
    case networkError
    case apiError
    case decodingError
}

enum APIEndpoints: String {
    
    case search = "/?s="

}

struct NetworkManager {
    
    
    let baseUrl = "http://www.omdbapi.com/"
    let apiKey = "eeefc96f"
    
//    http://www.omdbapi.com/?s=Batman&page=1&apikey=eeefc96f
    
    
    func prepareSearchRequest(query:String, page:Int) -> URLConvertible
    {
        let pathString:String = self.baseUrl + "\(APIEndpoints.search.rawValue)\(query)" + "&page=\(page)&&apikey=\(self.apiKey)"
        let req:URLConvertible = URL(string: pathString)!
        return req
    }
    
    func getSearchResults(query:String = "Batman",
                          endpoint:APIEndpoints,
                          page:Int = 1,
                          type:HTTPMethod = .get,
                          parameters:[String:Any] = [:],
                          completion: @escaping([MovieItem]?, APIError? ) -> ())
    {
                
        let requestURL = self.prepareSearchRequest(query: query, page: page)
        AF.request(requestURL, method: .get, parameters: parameters, headers: [:]).responseJSON { response in

//            print(response)
            
            switch response.result {
            case .failure:
                completion(nil, .networkError)
            case .success(let jsonData):
                var results:[MovieItem]?
                if let data = jsonData as? [String:Any] {

                    if let arr = data["Search"] as? [Dictionary<String,Any>] {
                        results = [MovieItem]()
                        for item in arr
                        {
                            let obj = MovieItem(dict: item)
                            results?.append(obj)
                        }
                        completion(results, nil)
                    } else {
                        completion(results, .decodingError)
                    }
                } else {
                    completion(results, .networkError)
                }
            }
       }
    }
}

