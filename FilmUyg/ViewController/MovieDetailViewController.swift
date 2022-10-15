//
//  MovieDetailViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 17.06.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    
    //bir önceki ekrandan tıkladığımız filmin kendisini bu nesneye atayacağız
    var movieDetay : PopMovieResult?
    var likedIMG = UIImage(named: "liked")
    var likeIMG = UIImage(named: "like")
    
    
    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var totalView: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    
    @IBOutlet weak var textDate: UILabel!
    @IBOutlet weak var textView: UILabel!
    @IBOutlet weak var textVote: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let resimLinki = self.movieDetay?.poster_path {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500"+resimLinki)
            filmImage.af_setImage(withURL: imageUrl!)
        }
        releaseDate.text = movieDetay?.release_date
        totalView.text = String(movieDetay?.popularity ?? 0)
        voteAverage.text = String(movieDetay?.vote_average ?? 0)
        movieOverview.text = movieDetay?.overview
        
        self.checkLikeButton()
    }
    
    
    func checkLikeButton() {
        if LikedMovies.shared.isLiked(movie: movieDetay!){
            let begenilmisFilm = UIBarButtonItem(image:likedIMG, style: .done, target: self, action: #selector(addFavorite))
            navigationItem.rightBarButtonItems = [begenilmisFilm]
            
        }
        else{
            let begenilmemisFilm = UIBarButtonItem(image:likeIMG, style: .done, target:self, action :#selector(addFavorite))
            navigationItem.rightBarButtonItems = [begenilmemisFilm]
        }
    }

    @objc func addFavorite() {
        print("tıklandı")
        if LikedMovies.shared.isLiked(movie: self.movieDetay!) {
            LikedMovies.shared.unLike(movie: self.movieDetay!)
            checkLikeButton()
        }
        else
        {
            LikedMovies.shared.like(movie: self.movieDetay!)
            checkLikeButton()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
}
