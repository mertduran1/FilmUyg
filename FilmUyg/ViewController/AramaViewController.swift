//
//  AramaViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 15.10.2022.
//

import UIKit
import Alamofire
import AlamofireImage
class AramaViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
  
  
    var timer = Timer()


    @IBOutlet weak var aramaBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    
    
    
    var movieArray  : PopMovies? // her sayfadaki 20 filmi temsil eder
       
       override func viewDidLoad() {
           super.viewDidLoad()
           self.title = "Arama"
           // Do any additional setup after loading the view.
      
       }

       override func viewWillAppear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: true)
       }
       
       
    @objc func AramaSonucuDataGetir() {
        let aramaApiUrl = "https://api.themoviedb.org/3/search/movie?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US&query=\(self.aramaBar.text!)&page=1&include_adult=false"
        
        let url  = aramaApiUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        Alamofire.request(url!).responseJSON { response -> Void in
            if let json = response.result.value {
                print(json)
            }
            //if else in ios tarafında
            guard let data = response.data else {return }
            do {
                let decoder = JSONDecoder()
                let jData = try decoder.decode(PopMovies.self, from :data)
                DispatchQueue.main.async {
                    self.movieArray = jData
                    print(self.movieArray?.results?.count ?? 0 )
                    self.searchTableView.reloadData()
                }
            }catch let err {
                print("Hata : ",err)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieArray?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = self.searchTableView.dequeueReusableCell(withIdentifier: "AramaCell", for: indexPath) as! SearchCell
        tableCell.selectionStyle = UITableViewCell.SelectionStyle.none
        //indexPath.row bize sıra numarası verir, bu sıra numarası
        if let siradakiFilm = self.movieArray?.results?[indexPath.row]
        {
            tableCell.cellName.text =  siradakiFilm.title
            tableCell.cellDate.text =  siradakiFilm.release_date
            tableCell.cellView.text =  String(siradakiFilm.popularity ?? 0)
            tableCell.cellVote.text =  String(siradakiFilm.vote_count ?? 0)
            
            if let resimLinki = siradakiFilm.poster_path {
                let imageUrl = URL(string: "https://image.tmdb.org/t/p/w500"+resimLinki)
                tableCell.cellImage.af_setImage(withURL: imageUrl!)
                
            }
        }
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        
        let navStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let movieDetailsViewController = navStoryboard.instantiateViewController(withIdentifier: "MovieDetailsVCID") as! MovieDetailViewController
        
        if let movie = self.movieArray?.results?[indexPath.row]
        {
            movieDetailsViewController.movieDetay = movie
        }
        
        // Close the keyboard
        self.view.endEditing(true)
        self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        print("searchText",searchText)
        self.AramaSonucuDataGetir()
        //timer.invalidate()
      //  timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.AramaSonucuDataGetir), userInfo: nil, repeats: true)
    }


}
