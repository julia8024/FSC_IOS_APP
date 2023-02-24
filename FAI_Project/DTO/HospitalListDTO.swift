//
//  HospitalListDTO.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/21.
//

import Foundation

struct HospitalListDTO : Codable, Identifiable {
    
    
    var hos_id : Int
    var hos_name : String
    var hos_address : String
    var hos_image : String
//    var avgRating : Float
    
    let id = UUID()
    
//    init(cafeId : String, cafeName : String, cafeAddress : String, avgRating : Float){
//        self.cafeId = cafeId
//        self.cafeName = cafeName
//        self.cafeAddress = cafeAddress
//        self.avgRating = avgRating
//    }
    
}
