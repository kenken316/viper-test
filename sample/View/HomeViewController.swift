//
//  HomeViewController.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit

protocol HomeView: AnyObject {
    
    func setLastSearchText(_ text: String)
    func showRefreshView()
    func updateRepositories(_ repositories: [Repository])
}

class HomeViewController: UIViewController {

    var presenter: HomeViewPresentation!

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "リポジトリ名を入力..."
        
        searchBar.delegate = self
        
        return searchBar
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    private var repositories: [Repository] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() // 画面の更新
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        navigationItem.titleView = searchBar
        
        let view = self
        let router = HomeRouter(viewController: view)
        let repositoryInteractor = SearchRepositoryInteractor()
        
        let presenter = HomeViewPresenter(view: view,
                                          router: router,
                                          repositoryInteractor: repositoryInteractor)
        self.presenter = presenter
    }

    @objc private func refreshControlValueChanged(sender: UIRefreshControl) {
        guard let text = searchBar.text else { return }
        
        presenter.refreshControlValueChanged(searchText: text)
    }
}

extension HomeViewController: HomeView {
    
    func setLastSearchText(_ text: String) {
        searchBar.text = text
    }
    
    func showRefreshView() {
        guard !refreshControl.isRefreshing else { return }
        
        refreshControl.beginRefreshingManually(in: tableView)
    }
    
    func updateRepositories(_ repositories: [Repository]) {
        self.repositories = repositories
    }
}

//MARK:- UITableView Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        cell.setRepository(repositories[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
}

//MARK:- UISearchBar Delegate
extension HomeViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        presenter.searchButtonDidPush(searchText: text)
        
        searchBar.resignFirstResponder()
    }
}
