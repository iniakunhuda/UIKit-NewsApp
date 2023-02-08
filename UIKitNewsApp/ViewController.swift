//
//  ViewController.swift
//  UIKitNewsApp
//
//  Created by Miftahul Huda on 05/02/23.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var notFoundLabel: UILabel!
    
    private let newsService = NewsService()
    var articles: [News] = []
    var filteredArticles: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Berita Terbaru"
        notFoundLabel.text = "Loading mengambil data..."
        
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        
        Task {
            articles = try await newsService.getHeadline()
            notFoundLabel.isHidden = true
            filteredArticles = articles
            table.reloadData()
        }
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArticles.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let article = filteredArticles[indexPath.row]
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.articleTitle.text = article.title
        
        
        let url = URL(string: article.urlToImage)
        let image = UIImage(named: "placeholder")
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        cell.articleImage.kf.setImage(with: url, placeholder: image, options: [.processor(processor)])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = filteredArticles[indexPath.row]
        if let url = URL(string: article.url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    // Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(ViewController.reload), object: nil)
        self.perform(#selector(ViewController.reload), with: nil, afterDelay: 0.5)
    }
    
    @objc func reload() {
        guard let searchText = searchBar.text else { return }
        notFoundLabel.isHidden = true
        
        if(searchText == "") {
            filteredArticles = articles
        } else {
            filteredArticles = articles.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
            if filteredArticles.isEmpty {
                notFoundLabel.isHidden = false
                notFoundLabel.text = "Hasil pencarian tidak ditemukan"
            }
        }
        table.reloadData()
    }
    
}

