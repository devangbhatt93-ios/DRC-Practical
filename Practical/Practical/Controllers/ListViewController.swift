//
//  ListViewController.swift
//  Practical
//
//  Created by Apple on 13/02/21.
//

import UIKit
import  Moya
import ObjectMapper

class ListViewController: UIViewController {

    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var navigationView: UIView!
    
    let articleProvider = MoyaProvider<ArticleServices>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: NetworkLoggerPlugin.Configuration.LogOptions.verbose))])

    lazy var arrArticles: [Articles] = []
    lazy var arrFilters: [FilterModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async {
            self.navigationView.setDropShadow(radius: 5, color: .gray)
        }
        
        articleListAPICall()
        makeFilters()
    }
    @IBAction func filterTapped(_ sender: UIButton) {
    }
    
}

// MARK: -  Custom Methods - api calls
extension ListViewController {
    
    // Custom Methods
    private func makeFilters() {
        let filterAll = FilterModel(name: "All", isSelected: true)
        let filterBusiness = FilterModel(name: "Business")
        let filterGadgets = FilterModel(name: "Gadgets")
        let filterSports = FilterModel(name: "Sports")
        let filterVideo = FilterModel(name: "Video")
        
        arrFilters.append(filterAll)
        arrFilters.append(filterBusiness)
        arrFilters.append(filterGadgets)
        arrFilters.append(filterSports)
        arrFilters.append(filterVideo)
        
        DispatchQueue.main.async {
            self.filterCollectionView.dataSource = self
            self.filterCollectionView.delegate = self
            self.filterCollectionView.reloadData()
        }
    }
    
    // API Call - Get all articles
    private func articleListAPICall() {
        articleProvider.request(.getArticleList(apiKey: "7ef6c6ad69394f70947a9f4a83b37864", source: "google-news")) { (result) in
            switch result {
            
            case .success(let response):
                do {
                    guard let dicResponse = try response.filterSuccessfulStatusCodes().mapJSON() as? [String: Any], let arrJSONArticles = dicResponse["articles"] as? [[String: Any]] else {
                        return
                    }
                    
                    self.arrArticles = Mapper<Articles>().mapArray(JSONArray: arrJSONArticles)
                    DispatchQueue.main.async {
                        self.articleTableView.dataSource = self
                        self.articleTableView.delegate = self
                        self.articleTableView.reloadData()
                    }
                    
                } catch {
                    print("error response", error.localizedDescription)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrFilters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        collectionCell.prepareCellFor(filter: arrFilters[indexPath.item])
        
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let filter = arrFilters[indexPath.item]
        arrFilters.forEach({ $0.isSelected = false })
        filter.isSelected = true
        collectionView.reloadData()
    }
}

extension ListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = arrFilters[indexPath.item].name ?? ""
        let size = name.size(withAttributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 14.0)!])
        
        return CGSize(width: size.width + 30, height: 60.0)
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticles.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as? ArticlesTableViewCell else {
            return UITableViewCell()
        }
        tableCell.prepareCellfor(article: arrArticles[indexPath.row])
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func applyShadowCardView(_ view: UIView, andCorner radi: Int)
    {
        view.layer.cornerRadius = CGFloat(radi)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}


extension UIView {
    
    func setDropShadow(radius : CGFloat, color: UIColor , offset: CGSize = CGSize.zero ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
}
