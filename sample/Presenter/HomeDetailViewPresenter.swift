//
//  HomeDetailViewPresenter.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import Foundation

protocol HomeDetailViewPresentation: class {
    func viewDidLoad()
}

class HomeDetailViewPresenter {
    
    private weak var view: HomeDetailView?
    private let router: HomeDetailWireframe
    private let repository: Repository

    init(view: HomeDetailView, router: HomeDetailWireframe, repository: Repository) {
        self.view = view
        self.router = router
        self.repository = repository
    }
}

extension HomeDetailViewPresenter: HomeDetailViewPresentation {

    func viewDidLoad() {
        view?.load(request: URLRequest(url: repository.htmlURL))
    }
}
