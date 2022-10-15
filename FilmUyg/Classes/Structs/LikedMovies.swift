//
//  File.swift
//  FilmUyg
//
//  Created by Mert Duran on 17.06.2022.
//

import Foundation

//singleton design pattern
struct LikedMovies : Codable {
    
    //eğer bu structt nesne oluşturma aşamasına geldiginde, hiç nesne oluşturulmadıysa 1 kerelik nesne oluşturulur
    //nesneye ihtiyac duyuldugunda sıfırdan olusturulmuyor, onun yerine varolan nesne üzerinden islemler gerçeklesiyor
    
    static var shared = LikedMovies()
    
    var likedMovies : [PopMovieResult] = []
    
    //detayına gittigimiz filmin likedmovies array icinde olup olmadıgını bize true yada false seklinde donecek
    func isLiked(movie : PopMovieResult) -> Bool {
        //contains like yapmak istedigim film likedMovies array icinde var ise true yoksa false değerini geri döner
        if likedMovies.contains(where: {$0.id == movie.id}) {
            return true
        }else {
            return false
        }
        
    }
    
    //detayına gittigim filmi like yapmamı sağlar
    mutating func like(movie : PopMovieResult)  { //değiştirilebilir oldugunu belirtmek icin mutating
        //eğer isLiked fonksiyonundan eklemek istedigim film ilgili arrayde var ise return diyerek hiç array eklemeden fonksiyondan cıkar
        if isLiked(movie:  movie) {
            return
        }
        likedMovies.append(movie)
        print(likedMovies)
        saveLikedMovies()
    }
    
    //kendisine gelen filmi likedMovies arrayinen kaldıracak
    mutating func unLike(movie : PopMovieResult) {
        if !isLiked(movie: movie) {
            return
        }
        likedMovies = likedMovies.filter{$0.id != movie.id}
        print(likedMovies)
        saveLikedMovies()
    }
    //kendisine string olarak gelen begenilmis film array ini user default ile uygulama icinde kaydeder
    func saveLikedMovies() {
        //UserDefault icinde STringe çevrilmis array i saklamamızı sağlayacak
        let begenilenFilmler = arrayToString(array : likedMovies)
        print(begenilenFilmler)
        UserDefaults.standard.set( begenilenFilmler, forKey: "SavedMovies")
    }
    //user defaults a kaydedilmis begenilmis filmleri tekrar arraye cevirir
    mutating func loadLikedMovies() {
        if let kaydedilmisFilmlerString = UserDefaults.standard.object(forKey: "SavedMovies") as? String {
            let begenilmisFilmDizisi = self.stringToArray(string: kaydedilmisFilmlerString)
            print(begenilmisFilmDizisi)
            self.likedMovies = begenilmisFilmDizisi
            print(likedMovies)
        }
        
    }
    //kendine gelen array bir string olarak geri dönecek
    func arrayToString(array : [PopMovieResult]) -> String  //kendisine gelen array string olarak geri dönüyor
    {
        let encoder = JSONEncoder()
        //encode ile gelen veriyi sifreleyip bir stringe donusturduk
        if let jsonData : Data = try? encoder.encode(array) {
            let dataString = String(data:jsonData, encoding:String.Encoding.utf8)
            return dataString!
        }
        return " "
    }
    
    //kendisine gelen string veriyi icindeki popmovieresult tipinde veri bulunduran bir arraya dönüstürür
    func stringToArray(string : String) -> [PopMovieResult] {
        let decoder = JSONDecoder()
        if let begenilenFilmlerArray = string.data(using: .utf8) {
            let jData = try? decoder.decode([PopMovieResult].self, from: begenilenFilmlerArray)
            return jData ?? []
        }
        return []
    }
        
}
