//
//  DatabaseService.swift
//  OrderApp
//
//  Created by 施馨檸 on 14/03/2018.
//  Copyright © 2018 施馨檸. All rights reserved.
//

import Foundation
import Firebase

class DatabaseService {
    
    static let shared = DatabaseService()
    private init() {}
    
    let postsReference = Database.database().reference().child("posts")
    let usersReference = Database.database().reference().child("users")
    
}
