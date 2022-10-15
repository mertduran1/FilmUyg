//
//  PopMovies.swift
//  FilmUyg
//
//  Created by Mert Duran on 15.06.2022.
//

import Foundation

//rest apideki tüm kayıtları ve tüm sayfaları temsil eder
struct PopMovies : Codable {
    var page : Int?
    var total_results : Int?
    var total_pages : Int?
    var results : [PopMovieResult]?
}

// her sayfadaki her bir filmi temsil eder
struct PopMovieResult : Codable {
    var poster_path : String?
    var adult : Bool?
    var overview : String?
    var release_date : String?
    var genre_ids : [Int]?
    var id : Int?
    var original_title : String?
    var original_language : String?
    var title : String?
    var backdrop_path : String?
    var popularity : Double?
    var vote_count : Int?
    var video : Bool?
    var vote_average : Double?
}
