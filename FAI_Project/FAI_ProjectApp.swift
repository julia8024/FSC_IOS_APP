//
//  FAI_ProjectApp.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI

var user: User = User() // 내 정보
//var cafe: Cafe = Cafe()  // 내 카페 정보

let host: String = "http://127.0.0.1:8000"


@main
struct FAI_ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
