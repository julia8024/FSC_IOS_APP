//
//  MainView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI
import Foundation

struct MainView: View {
    
    private enum Tabs {
        case HospitalList, Diagnosis, Profile
    }

    @State private var selectedTab: Tabs = .HospitalList


//    init() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithTransparentBackground()
//
//        UITabBar.appearance().backgroundColor = UIColor(Color("bgMainColor"))
//        UITabBar.appearance().standardAppearance = appearance
//    }


    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            HospitalListView()
                .tag(Tabs.HospitalList)
                .tabItem({
                    Image(systemName: "building.2")
                        .environment(\.symbolVariants, .none)
                    Text("병원")
                })
            DiagnosisView()
                .tag(Tabs.Diagnosis)
                .tabItem {
                    Image(systemName: "plus.circle")
                        .environment(\.symbolVariants, .none)
                    Text("AI 진단")
                }
            ProfileView()
                .tag(Tabs.Profile)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        .environment(\.symbolVariants, .none)
                    Text("My")
                }
        }
//        .accentColor(Color("mainPointColor"))
        .onAppear() {
            checkCameraPermission()
            checkAlbumPermission()
        }
        
    }
}

//
//extension UIImageView {
//    func load(url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.image = image
//                    }
//                }
//            }
//        }
//    }
//}

