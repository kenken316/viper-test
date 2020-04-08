//
//  HomeViewPresenter.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import Foundation

protocol HomeViewPresentation: AnyObject {
    func searchButtonDidPush(searchText: String)
    func refreshControlValueChanged(searchText: String)
    func didSelectRow(at indexPath: IndexPath)
}

class HomeViewPresenter {
    
    private weak var view: HomeView?
    private let router: HomeWireframe
    private let repositoryInteractor: SearchUsecase

    private var searchText: String = "" {
        didSet {
            guard !searchText.isEmpty else { return }
            
            view?.setLastSearchText(searchText)
            view?.showRefreshView()
            
            // Interactorへデータ取得の問い合わせ
            repositoryInteractor.fetchRepositories(keyword: searchText) { [weak self] result in
                switch result {
                case .success(let repositories):
                    self?.repositories = repositories
                case .failure:
                    self?.repositories.removeAll()
                }
            }
        }
    }
    
    private var repositories: [Repository] = [] {
        didSet {
            view?.updateRepositories(repositories)
        }
    }

    init(view: HomeView,
         router: HomeWireframe,
         repositoryInteractor: SearchUsecase) {
        
        self.view = view
        self.router = router
        self.repositoryInteractor = repositoryInteractor
    }

}

extension HomeViewPresenter: HomeViewPresentation {
    
    func refreshControlValueChanged(searchText: String) {
        self.searchText = searchText
    }
    
    func searchButtonDidPush(searchText: String) {
        self.searchText = searchText
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < repositories.count else { return }
        
        let repository = repositories[indexPath.row]
        router.showRepositoryDetail(repository)
    }
}
