//
//  DiagResult.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/23.
//

import Foundation

struct DiagResult: Codable {
    
    var diag_id: Int
    var diag_type: Int
    var diag_percent: Double
    
    init() {
        diag_id = 0
        diag_type = 7
        diag_percent = 0.0
    }

}
