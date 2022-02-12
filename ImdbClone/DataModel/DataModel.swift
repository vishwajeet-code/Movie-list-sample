//
//  DataModel.swift
//  ImdbClone
//
//  Created by Vishwajeet Singh on 11/02/22.
//

import Foundation

enum ItemType:String {
    
    case movie = "movie"
    case series = "series"
    case game = "game"
    case none = "na"
}

struct MovieItem {
    
//    {
//        Poster = "https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg";
//        Title = "Batman Begins";
//        Type = movie;
//        Year = 2005;
//        imdbID = tt0372784;
//    }
    
//    Type   : series
//    Year   : 2016–2017

    
    var title = ""
    var posterImg = ""
//    var type = ""
    var year = ""
    var imdbID = ""
    var displayDate = ""
    var type:ItemType = .movie
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "y"
        return formatter
    }()
    
    init(dict : Dictionary<String,Any> = [:]) {
        
        self.title = dict["Title"] as? String ?? ""
        self.posterImg = dict["Poster"] as? String ?? ""
        self.year = dict["Year"] as? String ?? ""
        self.imdbID = dict["imdbID"] as? String ?? ""
        let typeStr = dict["Type"] as? String ?? ""
        
        if !typeStr.isEmpty
        {
            self.type = ItemType(rawValue: typeStr)!
        }

        if !self.year.isEmpty
        {
            self.displayDate = self.makeDisplayDate(year: self.year, type: self.type)
        }
    }
    
    func makeDisplayDate(year: String, type:ItemType) -> String {

        let calendar = Calendar.current
        
        var yearValue:Int? // = Int(year)

        switch type {
        case .movie , .game:
            yearValue = Int(year)
            break
        
        case .series:
            let arr = year.components(separatedBy: "\u{2013}")
            if let startYear = arr.first {
                yearValue = Int(startYear)
            }
            break
        case .none:
            return "NA"
        }
        
        let components = calendar.dateComponents([.year], from: Date())
        if yearValue != nil && components.year != nil
        {
            let diff = components.year! - yearValue!
            return "\(diff) years back"
        }
        return "NA"
    }
    
}

extension MovieItem: CustomStringConvertible {
    var description: String {
        // create and return a String that is how
        // you’d like a Store to look when printed
        return """
        Name   : \(title)
        Poster : \(posterImg)
        Type   : \(type)
        Year   : \(year)
        Imdb ID: \(imdbID)

        """
    }
}
