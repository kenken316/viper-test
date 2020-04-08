//
//  HomeDetailViewController.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/03.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import UIKit
import WebKit

protocol HomeDetailView: class {
    
    func load(request urlRequest: URLRequest)
}

class HomeDetailViewController: UIViewController {

    var presenter: HomeDetailViewPresentation!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter.viewDidLoad()
    }
}

extension HomeDetailViewController: HomeDetailView {

    func load(request urlRequest: URLRequest) {
        webView.load(urlRequest)
    }
}
