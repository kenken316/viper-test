//
//  HomeDetailRouter.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/06.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit

protocol HomeDetailWireframe: class {
    
}

final class HomeDetailRouter {

    private unowned let viewController: UIViewController

    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension HomeDetailRouter: HomeDetailWireframe {

}
