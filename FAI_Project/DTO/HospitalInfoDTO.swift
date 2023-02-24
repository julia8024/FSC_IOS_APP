//
//  HospitalInfoDTO.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/21.
//

import Foundation

struct HospitalInfoDTO: Codable {
    
    var hos_id: Int
    var hos_name: String
    var hos_address: String
    var hos_phone: String
    var hos_introduce: String
    var hos_image: String
//    var avgRating: Float
//    var cafeImage: String
    
    init() {
        hos_id = 0
        hos_name = ""
        hos_address = ""
        hos_phone = ""
        hos_introduce = ""
        hos_image = ""
//        avgRating = 0
//        cafeImage = ""
    }
}
