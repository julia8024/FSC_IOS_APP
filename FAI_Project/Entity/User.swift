//
//  User.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import Foundation

// MARK: - User
struct User: Codable {
    var user_id: Int
    var user_email, user_name, user_password : String

    init(){
        user_id = 0
        user_email = ""
        user_name = ""
        user_password = ""
    }
    
    // 회원가입 생성자
    init(user_email: String, user_name: String, user_password: String) {
        self.user_id = 0
        self.user_email = user_email
        self.user_name = user_name
        self.user_password = user_password
    }
}

//struct JoinDTO: Codable {
//    var user_email, user_name, user_password : String
//    
//    // 회원가입 생성자
//    init(user_email: String, user_name: String, user_password: String) {
//        self.user_email = user_email
//        self.user_name = user_name
//        self.user_password = user_password
//    }
//}

//struct EditUserDTO : Codable {
//
//    var user_name, user_password: String
//
//    init(user_name: String, user_password: String) {
//        self.user_name = user_name
//        self.user_password = user_password
//    }
//
//}
