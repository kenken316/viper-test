//
//  SearchResponse.swift
//  sample
//
//  Created by 高橋 謙太 on 2020/04/06.
//  Copyright © 2020 takahashi_ke. All rights reserved.
//

import Foundation

struct SearchResponse<Item: Decodable>: Decodable {

    let totalCount: Int
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
