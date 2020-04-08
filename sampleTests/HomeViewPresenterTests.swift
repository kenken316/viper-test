//
//  HomeViewPresenterTests.swift
//  sampleTests
//
//  Created by 高橋 謙太 on 2020/04/07.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import XCTest
@testable import sample

class HomeViewPresenterTests: XCTestCase {

    var view: ViewMock!
    var router: RouterMock!
    var repositoryInteractor: RepositoryInteractorMock!
    var presenter: HomeViewPresenter!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        view = .init()
        router = .init()
        repositoryInteractor = .init()
        presenter = .init(view: view, router: router, repositoryInteractor: repositoryInteractor)
    }
    
    func test_searchButtonDidPush() {
        // PresenterにsearchButtonDidPushイベントが届いたときの挙動をテスト
        XCTContext.runActivity(named: "searchButtonDidPush") { _ in
            XCTContext.runActivity(named: "when before called") { _ in
                XCTContext.runActivity(named: "`fetchRepositories` is not called") { _ in
                    XCTAssertEqual(repositoryInteractor.callCount_fetchRepositories, 0)
                }
            }
            
            XCTContext.runActivity(named: "when after called") { _ in
                XCTContext.runActivity(named: "`fetchRepositories` is called") { _ in
                    presenter.searchButtonDidPush(searchText: "Swift")
                    XCTAssertEqual(repositoryInteractor.callCount_fetchRepositories, 1)
                }
                
                XCTContext.runActivity(named: "when `fetchRepositories` response error") { _ in
                    setUp()
                    repositoryInteractor = .init(result: .failure(NSError()))
                    presenter = .init(view: view, router: router, repositoryInteractor: repositoryInteractor)
                    
                    presenter.searchButtonDidPush(searchText: "Swift")
                }
                
                XCTContext.runActivity(named: "when `fetchRepositories` response succeed") { _ in
                    setUp()
                    let repositories = [
                        Repository(id: 0,
                                   name: "Swift",
                                   fullName: "apple/Swift",
                                   htmlURL: URL(string: "https://github.com/apple/Swift/")!,
                                   starCount: 100000,
                                   owner: User(id: 0, login: "apple"))
                    ]
                    repositoryInteractor = .init(result: .success(repositories))
                    presenter = .init(view: view, router: router, repositoryInteractor: repositoryInteractor)
                    
                    presenter.searchButtonDidPush(searchText: "Swift")
                    
                    XCTContext.runActivity(named: "`updateRepositories` is called") { _ in
                        XCTAssertEqual(view.callCount_updateRepositories, 1)
                    }
                }
            }
        }
    }
    
    // MARK: - mock
    class ViewMock: HomeView {
        
        var callCount_setLastSearchText = 0
        func setLastSearchText(_ text: String) {
            callCount_setLastSearchText += 1
        }
        
        var callCount_showRefreshView = 0
        func showRefreshView() {
            callCount_showRefreshView += 1
        }
        
        var callCount_updateRepositories = 0
        func updateRepositories(_ repositories: [Repository]) {
            callCount_updateRepositories += 1
        }
        
        var callCount_showErrorMessageView = 0
        func showErrorMessageView(reason: String) {
            callCount_showErrorMessageView += 1
        }
    }
    
    class RouterMock: HomeWireframe {
        
        var isCalled_showRepositoryDetail = false
        func showRepositoryDetail(_ repository: Repository) {
            isCalled_showRepositoryDetail = true
        }
    }
    
    class RepositoryInteractorMock: SearchUsecase {
        
        let result: Result<[Repository], Error>
        
        init(result: Result<[Repository], Error> = .failure(NSError())) {
            self.result = result
        }
        
        var callCount_fetchRepositories = 0
        func fetchRepositories(keyword: String, completion: @escaping (Result<[Repository], Error>) -> Void) {
            callCount_fetchRepositories += 1
            completion(result)
        }
    }

//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
