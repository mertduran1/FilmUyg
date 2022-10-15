//
//  GenreViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 7.10.2022.
//

import UIKit
import Alamofire
import AlamofireImage
class GenreViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource  {
    
    var genreID : Int?
    
    var categoryDetail : PopMovies?
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    func getJSONMovies(){
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&with_genres=\(genreID ?? 0)").responseJSON{ response in
            
            
                guard let data = response.data else {return}
                do {
                    let decoder = JSONDecoder()
                    let jData = try decoder.decode(PopMovies.self, from: data)
                    DispatchQueue.main.async {
                        self.categoryDetail = jData
                        print(self.categoryDetail?.results?.count ?? 0)
                        self.categoryCollectionView.reloadData()
                    }
                    
                } catch let hata {
                    print("hata : " , hata)
                }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getJSONMovies()
        print(genreID ?? 0)
        // Do any additional setup after loading the view.
        let widthSize = UIScreen.main.bounds.width/3-4
        let heightSize = UIScreen.main.bounds.height/3.3-4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        categoryCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryDetail?.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "kategoriCell", for: indexPath) as! CategoryListClassCollectionViewCell
        
      let kategoriMovies = self.categoryDetail?.results![indexPath.row]
            
        cell.movieName.text = kategoriMovies?.title
            
        if let resimLink = kategoriMovies?.poster_path {
            
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500"+resimLink)
            cell.movieImage.af_setImage(withURL: imageURL!)
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gidilecekStoryBoard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let movieDetailVC = gidilecekStoryBoard.instantiateViewController(withIdentifier: "MovieDetailsVCID") as! MovieDetailViewController
        if let selectedMovie = categoryDetail?.results![indexPath.row] {
            
            movieDetailVC.movieDetay = selectedMovie
        }
        self.navigationController?.pushViewController(movieDetailVC, animated: false)
    }
}
