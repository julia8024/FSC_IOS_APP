//
//  DiagnosisListDTO.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/23.
//

import Foundation

struct DiagnosisListDTO: Codable, Identifiable {
    
    var diag_id: Int
    var diag_image: String
    var diag_date: String

    let id = UUID()
}
