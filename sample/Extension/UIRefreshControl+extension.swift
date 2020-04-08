//
//  UIRefreshControl+extension.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/06.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit

extension UIRefreshControl {
    
    func beginRefreshingManually(in scrollView: UIScrollView) {
        beginRefreshing()
        let offset = CGPoint.init(x: 0, y: -frame.size.height)
        scrollView.setContentOffset(offset, animated: true)
    }
}
