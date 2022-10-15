//
//  KategoriViewController.swift
//  FilmUyg
//
//  Created by Mert Duran on 10.06.2022.
//

import UIKit
import Alamofire
class KategoriViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource{
  
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    var movieKategoryArray : Genre?
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Kategoriler"
        // Do any additional setup after loading the view.
        self.getJsonCategories()
    }
    

    enum MovieCategories : String {
        case Action
        case Adventure
        case Animation
        case Comedy
        case Crime
        case Documentary
        case Drama
        case Family
        case Fantasy
        case History
        case Horror
        case Music
        case Mystery
        case Romance
        case ScienceFiction
        case Thriller
        case TVMovie
        case War
        case Western
        case Default
        
    }
    
    func getImage(genreName :MovieCategories, cell : CategoryCollectionViewCell)
    {
        print(genreName)
        switch genreName {
        case .Action:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Adventure:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Animation:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Comedy:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Crime:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Documentary:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Drama:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Family:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Fantasy:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .History:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Horror:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Music:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Mystery:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Romance:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .ScienceFiction:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Thriller:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .TVMovie:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .War:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Western:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        case .Default:
            let image = UIImage.init(named: genreName.rawValue)
            cell.cellCategoryImage.image = image
        }
    }
    
    func nameTrim(name : String) -> String {
        let bosluklariKaldir = name.replacingOccurrences(of: " ", with: "")
        return bosluklariKaldir
    }
    
    func getJsonCategories()
    {
        Alamofire.request("https://api.themoviedb.org/3/genre/movie/list?api_key=b155b3b83ec4d1cbb1e9576c41d00503&language=en-US").responseJSON { (gelenKategoriListesi) -> Void in
            
            if gelenKategoriListesi.result.isFailure {
                print("hata oluştu")
            }else
            {
                guard let data = gelenKategoriListesi.data else {return}
                do
                {
                    let decoder = JSONDecoder()
                    //
                    let jsonData = try decoder.decode(Genre.self, from: data)
                    DispatchQueue.main.async {
                        self.movieKategoryArray = jsonData
                        print(self.movieKategoryArray?.genres?.count ?? 0 )
                        self.categoryCollectionView.reloadData()
                    }
                    
                }
                catch let hata {
                    print("Hata oluştu : ", hata)
                }
                
            }
            
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieKategoryArray?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let categoryCell  =  collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCollectionViewCell
        
        if let category  = self.movieKategoryArray?.genres?[indexPath.row]
        {
            categoryCell.cellCategoryName.text = category.name
            let bosluk = nameTrim(name: category.name ?? "")
            if let categoryEnum : MovieCategories = MovieCategories(rawValue: bosluk)
            {
                getImage(genreName: categoryEnum, cell: categoryCell)
            }
            else
            {
                getImage(genreName: .Default, cell: categoryCell)
            }
            
        }
        
        return categoryCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gidilecekStoryBoard  = UIStoryboard.init(name: "Main", bundle: nil)
        let genreViewController = gidilecekStoryBoard.instantiateViewController(withIdentifier: "GenreViewContrellerID") as! GenreViewController
        if let seciliKategori = self.movieKategoryArray?.genres?[indexPath.row]
        {
            let id = seciliKategori.id
            genreViewController.genreID = id
            
        }
        
        self.navigationController?.pushViewController(genreViewController, animated: true)
        
    }
}
