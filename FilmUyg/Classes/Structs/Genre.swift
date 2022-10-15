//
//  Genre.swift
//  FilmUyg
//
//  Created by Mert Duran on 15.06.2022.
//

import Foundation


struct Genre : Codable {
    var genres : [Genres]?
}

struct Genres : Codable {
    var  id : Int?
    var name : String?
}




