//
//  DiagnosisInfoView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/23.
//

import SwiftUI

struct DiagnosisInfoView: View {
    
    @ObservedObject var diagnosisController = DiagnosisController()
    
//    @Binding var isPresented: Bool
    
//    init(isPresented: Binding<Bool>) {
    init() {
//        self._isPresented = isPresented
        diagnosisController.getDiagnosisList()
    }
    
    var body: some View {
        VStack {
            
            if self.diagnosisController.diagnosisList.count == 0 {
                Text("AI 진단 기록이 아직 없습니다")
                    .foregroundColor(Color("grayTextColor"))
                    .frame(maxWidth: .infinity)
                    .padding(30)
                Spacer()
            } else {
                List(self.diagnosisController.diagnosisList) { diagnosisListDTO in
                    DiagnosisListRow(diagnosisListDTO)
                }
                .listStyle(.plain)
                .padding(.bottom, 1)
                .padding(.horizontal, 30)
                .background(Color("bgMainColor"))
            }
            
        }
        .navigationTitle("AI 진단 기록 조회")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color("bgMainColor"))
        .refreshable {
            self.diagnosisController.getDiagnosisList()
        }
    }
}

struct DiagnosisListRow: View {
    
    @ObservedObject var diagnosisController = DiagnosisController()
    
//    @State var popDelMenuAlert: Bool = false
    var diagnosisListDTO: DiagnosisListDTO
    
    init(_ diagnosisListDTO: DiagnosisListDTO) {
        self.diagnosisListDTO = diagnosisListDTO
        self.diagnosisController.getDiagResult(diag_id: diagnosisListDTO.diag_id)
    }
    
    var body: some View {
        
        HStack {
            AsyncImage(url: URL(string: getImage(diagnosisListDTO.diag_image))) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .clipped()
            } placeholder: {
                Spacer()
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24))
                    .foregroundColor(Color("mainPointColor"))
                Spacer()
            }
            .frame(maxWidth: 100, maxHeight: 100)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.trailing, 4)
            .padding(.leading, 0).ignoresSafeArea()
            
            VStack (alignment: .leading) {
                Text("\(getDiagName(diag_type: diagnosisController.diagResultforList.diag_type))")
                    .font(.system(size: 16))
                    .padding(.bottom, 2)
                
                Text("\(diagnosisController.diagResultforList.diag_percent)%")
                    .font(.system(size: 18))
                    .foregroundColor(Color("mainPointColor"))
                    .fontWeight(.bold)
                    .padding(.bottom, 2)
                
                Text(diagnosisListDTO.diag_date)
                    .font(.system(size: 12))
                    .foregroundColor(Color("grayTextColor"))
            } // hstack
            .padding(.vertical, 20)
            .background(Color("bgMainColor"))
            .listRowBackground(Color("bgMainColor"))
            
            
        }
        
    }
    
    func getImage(_ imageName: String) -> String {
        // make 'serverData' by json decode 'data'
        var imageURL = host + "/diagnosis" + imageName
        return imageURL
    }
    
    
    func getDiagName(diag_type: Int) -> String {
        var typeList = ["Actinic keratoses", "Basal cell carcinoma", "Benign keratosis-like lesions", "Dermatofibroma", "Melanoma", "Melanocytic nevi", "Vascular lesions", ""]
        return typeList[diag_type]

    }
}
