//
//  SearchInteractor.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import Foundation

protocol SearchUsecase: AnyObject {
    
    func fetchRepositories(keyword: String,
                           completion: @escaping (Result<[Repository], Error>) -> Void)
}

final class SearchRepositoryInteractor {
    
    private let client: GitHubRequestable

    init(client: GitHubRequestable = GitHubClient()) {
        self.client = client
    }
}

extension SearchRepositoryInteractor: SearchUsecase {
    
    func fetchRepositories(keyword: String,
                           completion: @escaping (Result<[Repository], Error>) -> Void) {
        let request = GitHubAPI.SearchRepositories(keyword: keyword)
        client.send(request: request) { result in
            completion(result.map { $0.items })
        }
    }
}
