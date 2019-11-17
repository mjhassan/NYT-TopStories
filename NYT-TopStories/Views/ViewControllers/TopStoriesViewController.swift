//
//  TopStoriesViewController.swift
//  NYT-TopStories
//
//  Created by Jahid Hassan on 11/15/19.
//  Copyright © 2019 Jahid Hassan. All rights reserved.
//

import UIKit

class TopStoriesViewController: UIViewController {

    @IBOutlet weak var _tableView: UITableView!
    
    private lazy var viewModel: TopStoriesProtocol = {
        let _viewModel = TopStoriesViewModel(bind: self)
        return _viewModel
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar:UISearchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.autocapitalizationType = .none
        searchBar.returnKeyType = .done
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(relaodData), for: .valueChanged)
        return refresh
    }()
    
    private lazy var progressHud: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .gray)
        indicator.hidesWhenStopped = true
        indicator.center = view.center
        view.addSubview(indicator)
        
        return indicator
    }()
    
    private var loading: Bool = false {
        didSet {
            invoke(onThread: DispatchQueue.main) { [weak self] in
                guard let _weakSelf = self else { return }
                
                if !_weakSelf.progressHud.isAnimating && _weakSelf.loading == false { return }
                
                _weakSelf.loading ? _weakSelf.progressHud.startAnimating():_weakSelf.progressHud.stopAnimating()
                _weakSelf.refreshControl.endRefreshing()
                UIApplication.shared.isNetworkActivityIndicatorVisible = _weakSelf.loading
            }
        }
    }
    
    private let segue_id = "DetailViewControllerSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        relaodData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segue_id,
            let destination = segue.destination as? DetailViewController {
            destination.viewModel = DetailViewModel(article: sender as! Article)
        }
    }
}

fileprivate extension TopStoriesViewController {
    func configureViews() {
        navigationItem.titleView = Banner.view
        
        _tableView.register(ArticleCell.nib, forCellReuseIdentifier: ArticleCell.identifier)
        _tableView.tableHeaderView = searchBar
        _tableView.tableFooterView = UIView()
        _tableView.addSubview(refreshControl)
    }
    
    @objc func relaodData() {
        guard loading == false else { return }
        
        invoke(after: 0.1) { [unowned self] in
            self.viewModel.fetchData()
        }
    }
    
    @objc func search(_ txt: String) {
        viewModel.filter = txt
    }
    
    func showAlert(_ msg: String) {
        let alert = UIAlertController(title: "ERROR", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension TopStoriesViewController: TopStoriesViewControllerDelegate {
    func willStartFetchingData() {
        loading = true
    }
    
    func didFinishFetchingData() {
        loading = false
        invoke(onThread: DispatchQueue.main) { [unowned self] in
            self._tableView.reloadData()
        }
    }
    
    func didFailedWithError(_ description: String) {
        loading = false
        invoke(onThread: DispatchQueue.main) { [unowned self] in
            self.showAlert(description)
        }
    }
}

extension TopStoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articleCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as! ArticleCell
        articleCell.article = viewModel.article(at: indexPath.item)
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let article = viewModel.article(at: indexPath.item) else {
            return
        }
        
        performSegue(withIdentifier: segue_id, sender: article)
    }
}

extension TopStoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: textSearched)
        self.perform(#selector(search), with: textSearched, afterDelay: 0.5)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
