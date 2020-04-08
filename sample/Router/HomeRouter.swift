//
//  HomeRouter.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit

protocol HomeWireframe: AnyObject {
    
    func showRepositoryDetail(_ repository: Repository)
}

final class HomeRouter {

    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeWireframe {

    func showRepositoryDetail(_ repository: Repository) {
        
        let sb = UIStoryboard(name: "main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "HomeDetailViewController") as! HomeDetailViewController
        
        let router = HomeDetailRouter(viewController: vc)
        let presenter = HomeDetailViewPresenter(view: vc, router: router, repository: repository)

        vc.presenter = presenter

        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
