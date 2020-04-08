//
//  Repository.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/06.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import Foundation

struct Repository: Decodable {

    let id: Int
    let name: String
    let fullName: String
    let htmlURL: URL
    let starCount: Int
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlURL = "html_url"
        case starCount = "stargazers_count"
        case owner
    }
}
