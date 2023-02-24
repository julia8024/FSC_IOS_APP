//
//  LoginDTO.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import Foundation


struct LoginDTO : Codable {
    
    var user_email: String
    var user_password: String
    
    init(user_email: String, user_password: String) {
        self.user_email = user_email
        self.user_password = user_password
    }
    
}
