//
//  PopulerController.swift
//  FilmUyg
//
//  Created by Mert Duran on 7.10.2022.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import SVProgressHUD
import SwiftSpinner

class PopulerController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
 
    @IBOutlet weak var populerMovieCollectionView: UICollectionView!
    
    var movie : PopMovies?  // her bir page içindeki 20 filmi
    var isLoadingMore = false
    let URL_GET_DATA = "https://api.themoviedb.org/3/discover/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popüler Filmler"
        LikedMovies.shared.loadLikedMovies()
        // Do any additional setup after loading the view.
        let widthSize = UIScreen.main.bounds.width/3-4
        let heightSize = UIScreen.main.bounds.height/3.3-4
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: widthSize, height: heightSize)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        populerMovieCollectionView.collectionViewLayout = layout
        self.getJSONMovies()
    }
    
    func getJSONMovies(){
        Alamofire.request(URL_GET_DATA).responseJSON{ response in
            //if let json = response.result.value {
               // print(json)
           // }
            //if else in ios tarafında
            guard let data = response.data else {return }
            do {
                let decoder = JSONDecoder()
                let jData = try decoder.decode(PopMovies.self, from :data)
                DispatchQueue.main.async {
                    self.movie = jData
                    print(self.movie?.results?.count ?? 0 )
                    self.populerMovieCollectionView.reloadData()
                }
            }catch let err {
                print("Hata : ",err)
            }
        }
    }
    
    //Main Thread
    
    func loadMoreJSON(){
        if self.isLoadingMore {
            return
        }
        self.isLoadingMore = true
        let page = self.movie?.page
        print(page!)
        SwiftSpinner.show("Yükleniyor...")
        Alamofire.request("https://api.themoviedb.org/3/discover/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page!+1)").responseJSON { (response) -> Void in
            if(response.result.isFailure) {
                print("Hata oluştur")
            }
            else
            {
                guard let data = response.data else {return }
                do {
                    let decoder = JSONDecoder() // gelen datayı parse edecek nesne
                    let jData = try decoder.decode(PopMovies.self, from:data)
                    DispatchQueue.main.async {
                        self.movie?.results?.append(contentsOf: (jData.results ?? []))
                        self.populerMovieCollectionView.reloadData()
                        self.isLoadingMore = false
                    }
                }catch let hata {
                    print("Hata oluştu",hata)
                }
            }
            SwiftSpinner.hide()
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movie?.results?.count ?? 0   // movie içendeki results içindeki kayıt sayısı kadar yada sıfır kayıt gösterecer
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.populerMovieCollectionView.dequeueReusableCell(withReuseIdentifier: "populermoviecells", for: indexPath) as! cellClass
        if let siradakiFilm  = self.movie?.results?[indexPath.row]
        {
            print(indexPath.row)
            print(siradakiFilm.title!)
            print(siradakiFilm.poster_path!)
            cell.cellName.text = siradakiFilm.title
            if let resimLinki = siradakiFilm.poster_path {
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500"+resimLinki)
                cell.cellImage.af_setImage(withURL: imageUrl!)
            }
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.movie?.results?.count)!-4 {
            loadMoreJSON()
            self.movie?.page? += 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let navStoryBoard  = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDetailController = navStoryBoard.instantiateViewController(withIdentifier: "MovieDetailsVCID") as! MovieDetailViewController
        
        print(self.movie?.page!)
        print(indexPath.row)
        //indexPath.row dan gelen sıra numarası ile birlikte
        // ilgili sayfanın ilgili results içindeki array den bir nesne oluşturucak
        if let seciliFilm = self.movie?.results?[indexPath.row]
        {
            print(seciliFilm.title!)
            movieDetailController.movieDetay = seciliFilm
        }
        
        
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
    
    

}

