//
//  HospitalListView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI

struct HospitalListView: View {

    @ObservedObject var hospitalController = HospitalController()
    
    @State private var inputSearch: String = ""
    
    init() {
        hospitalController.getHospitalList()
    }
    
    var body: some View {
        VStack {
            VStack {
                Text("병원 리스트")
                    .font(.system(size: 32))
                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 30)
            .padding(.top, 30)
            .padding(.bottom, 0)
            
            // 검색
            HStack {
                TextField("검색", text: $inputSearch)
                    .padding(.leading, 20)
                    .padding(.vertical, 10)
                    .font(.system(size:16))
                    .textInputAutocapitalization(.never)
                Image(systemName: "magnifyingglass")
                    .environment(\.symbolVariants, .none)
                    .imageScale(.medium)
                    .foregroundColor(Color("mainPointColor"))
                    .padding(.trailing, 20)
                    .padding(.vertical, 10)
                    .onTapGesture {
                        if inputSearch != "" {
                            hospitalController.searchHospitalList(inputSearch)
                        } else {
                            hospitalController.getHospitalList()
                        }
                    }
            } // hstack
            .frame(maxWidth: .infinity)
            .background(Color("bgColor"))
            .border(Color.black.opacity(0), width: 0)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("borderColor"), lineWidth: 1)
                
            )
            .padding(30)

            
            
            if hospitalController.hospitalList.count == 0 {
                Text("해당하는 검색 결과가 없습니다")
                    .foregroundColor(Color("grayTextColor"))
                    .frame(maxWidth: .infinity)
                    .padding(30)
                Spacer()
            } else {
                List(hospitalController.hospitalList) { hospitalListDTO in
                    
                    HospitalListRow(hospitalListDTO)
                    
                }
                .listStyle(.plain)
                .padding(.horizontal, 15)
                .padding(.top, 0).ignoresSafeArea()
                .padding(.bottom, 1)
                .background(Color("bgMainColor"))
            }
            
            
            
            
        } // vstack
        .navigationBarTitleDisplayMode(.inline)
//        .navigationTitle(Text("카페 리스트").font(.system(size: 28)))
        .background(Color("bgMainColor"))
        .refreshable {
            self.hospitalController.getHospitalList()
        }
        
    }
}


struct HospitalListRow: View {
    
//    var cafeId : String
//    var cafeName : String
//    var cafeAddress : String
//    var avgRating : Float
    
    var hospitalListDTO : HospitalListDTO
    
    @State private var isActive: Bool = false
    
    init(_ hospitalListDTO: HospitalListDTO) {
        self.hospitalListDTO = hospitalListDTO
//        self.cafeId = Int(cafeListDTO.cafeId) ?? 0
    }
    
    var body: some View {
        ZStack {
            if (isActive == true) {
                NavigationLink(destination: HospitalInfoView(hospitalListDTO.hos_id), isActive: $isActive) {
                    EmptyView()
                } //navigationlink
                .opacity(0.0)
                //            .hidden()
                .buttonStyle(PlainButtonStyle())
            }
            
            HStack {
                AsyncImage(url: URL(string: getImage(hospitalListDTO.hos_image))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Spacer()
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .font(.system(size: 24))
                        .foregroundColor(Color("mainPointColor"))
                    Spacer()
                }
                .frame(maxWidth: 100)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.trailing, 4)
                .padding(.leading, 0).ignoresSafeArea()
                
                VStack (alignment: .leading) {
                    Text("\(hospitalListDTO.hos_name)").font(.system(size: 16))
                        .padding(.bottom, 10)
                    Text("\(hospitalListDTO.hos_address)").font(.system(size: 12))
                        .foregroundColor(Color("grayTextColor"))
                } // vstack
            }
//            .padding(10)
        }
        .background(Color("bgMainColor"))
        .listRowBackground(Color("bgMainColor"))
        .onTapGesture {
            isActive.toggle()
        }
    }
    func getImage(_ imageName: String) -> String {
        // make 'serverData' by json decode 'data'
        var imageURL = host + "/hospital" + imageName
        return imageURL
    }
}
