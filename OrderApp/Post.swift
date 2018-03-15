//
//  Post.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import Foundation
struct Posts: Codable {
    
    
    struct Food: Codable {
        var name: String
        var pic: URL
    }
    
    struct Post: Codable {
        let meat: Food
        let dish1: Food
        let dish2: Food
        let soup: Food
    }
    
    var mon: Post?
    var tue: Post?
    var wed: Post?
    var thu: Post?
    var fri: Post?
}
