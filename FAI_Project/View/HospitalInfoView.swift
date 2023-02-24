//
//  HospitalInfoView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/21.
//

import SwiftUI

struct HospitalInfoView: View {
    
    @ObservedObject var hospitalController = HospitalController()
//    @ObservedObject var reviewController = ReviewController()
    
//    @State private var isActiveWrite: Bool = false
//    @State var reviewSettings: Bool = false
    
//    @State var reviewSettings: Bool = false

    
//    var maxRating = 5

//    var offImage = Image(systemName: "star")
//    var onImage = Image(systemName: "star.fill")
    
    init(_ hos_id: Int) {
        self.hospitalController.getHospitalInfo(hos_id: hos_id)
//        self.reviewController.getReivewList(cafeId: cafeId)
        
//        self.imageController.downloadFile(cafeImage: cafeController.cafeInfo.cafeImage)
    }

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: getImage(hospitalController.hospitalInfo.hos_image))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .font(.system(size: 24))
                        .foregroundColor(Color("mainPointColor"))
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                VStack(alignment: .leading) {
                    Label {
                        // 지도
                        Text("\(hospitalController.hospitalInfo.hos_address)")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(5)
                    } icon : {
                        Image(systemName: "map")
                            .environment(\.symbolVariants, .none)
                            .font(.system(size: 16))
                            .foregroundColor(Color("mainPointColor"))
                    }
                    .padding(.bottom, 20)
                    Label {
                        // 전화번호
                        Text("\(hospitalController.hospitalInfo.hos_phone)")
                            .font(.system(size: 14))
                    } icon : {
                        Image(systemName: "phone")
                            .environment(\.symbolVariants, .none)
                            .font(.system(size: 16))
                            .foregroundColor(Color("mainPointColor"))
                    }
                    .padding(.bottom, 20)
                    
                    Label {
                        // 한줄소개
                        Text(hospitalController.hospitalInfo.hos_introduce)
                            .font(.system(size: 14))
                            .lineSpacing(5)
                    } icon : {
                        Image(systemName: "quote.bubble")
                            .environment(\.symbolVariants, .none)
                            .font(.system(size: 16))
                            .foregroundColor(Color("mainPointColor"))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(20)

            } // vstack
            .frame(maxWidth: .infinity)
            .background(Color("bgColor"))
            .border(Color.black.opacity(0), width: 0)
            .cornerRadius(20)
            .padding(30)
            .shadow(color: .gray.opacity(0.4), radius: 5, x: 0, y: 0)
            
        } // scrollView
        .navigationTitle("\(hospitalController.hospitalInfo.hos_name)")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("bgMainColor"))
//        .onAppear() {
//            print("reviewList: \(reviewController.reviewList)")
//        }
        .refreshable {
            self.hospitalController.getHospitalInfo(hos_id: self.hospitalController.hospitalInfo.hos_id)
//            self.reviewController.getReivewList(cafeId: self.cafeController.cafeInfo.cafeId)
        }
    }
    
    func getImage(_ imageName: String) -> String {
        // make 'serverData' by json decode 'data'
        var imageURL = host + "/hospital" + imageName
        return imageURL
    }
    
//    func image(for number: Int) -> Image {
//        // 별점이 5보다 작으면
//        print("\(number)")
//        if number > Int(cafeController.cafeInfo.avgRating) {
//
//            return offImage ?? onImage
//        } else {
//            // 별점이 5인 경우
//            return onImage
//        }
//    }
}
