//
//  FavoriViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 10.06.2022.
//
import UIKit
import AlamofireImage

class FavoriViewController: UIViewController {
    
    @IBOutlet weak var favorilerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let widthSize = UIScreen.main.bounds.width/3-4
        let heightSize = UIScreen.main.bounds.height/3.3-4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        favorilerCollectionView.collectionViewLayout = layout
       
        

        self.title = "Favoriler"
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favorilerCollectionView.reloadData()
    }
    

}

extension FavoriViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return LikedMovies.shared.likedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let favCell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorilerCell", for: indexPath) as! FavorilerCollectionViewCell
        let favoriFilm  = LikedMovies.shared.likedMovies[indexPath.row]
        favCell.cellFavorilerName.text = favoriFilm.title
        if let resimLinki = favoriFilm.poster_path {
            let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500"+resimLinki)
            favCell.cellFavorilerImage.af_setImage(withURL: imageUrl!)
        }
        
        print(LikedMovies.shared.likedMovies.count)
        return favCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let navStoryBoard  = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDetailController = navStoryBoard.instantiateViewController(withIdentifier: "MovieDetailsVCID") as! MovieDetailViewController
        
       // print(self.movie?.page!)
       // print(indexPath.row)
        //indexPath.row dan gelen sıra numarası ile birlikte
        // ilgili sayfanın ilgili results içindeki array den bir nesne oluşturucak
        let seciliFilm = LikedMovies.shared.likedMovies[indexPath.row]
        
        movieDetailController.movieDetay = seciliFilm
        
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    
}
