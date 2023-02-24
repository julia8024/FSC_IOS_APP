//
//  HospitalController.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/21.
//

import Foundation
import Alamofire

class HospitalController: ObservableObject {
    
    @Published var hospitalList = [HospitalListDTO]()
    @Published var hospitalInfo = HospitalInfoDTO()
    
    func getHospitalList() {
        
        let url = host + "/hospital/list"
        
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "GET"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of: [HospitalListDTO].self) { response in
            print("alamofire 실행~~")

            switch response.result {
            case .success(let value):
                print("호출 성공 getHospitalList")
                self.hospitalList = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 getHospitalList")
            }
        }
        
    }
    
    func getHospitalInfo(hos_id: Int) {
//        /cafe/{cafeId}?userId={userId}
//        let url = host + "/cafe/" + cafeId + "?userId=" + String(user.userId)
        let url = host + "/hospital/info/" + String(hos_id)
        
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "GET"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of: HospitalInfoDTO.self) { response in
            print("alamofire 실행~~")

            switch response.result {
            case .success(let value):
                print("호출 성공 getHospitalInfo")
                self.hospitalInfo = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 getHospitalInfo")
            }
        }
    }
    
    
    func searchHospitalList(_ search: String) {
        let url = host + "/hospital/search/" + search
        
        // URLRequest 객체 생성 (url 전달)
//        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
//        request.httpMethod = "GET"
        // 헤더 정보 설정
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request((host + "/hospital/search/" + search).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "").responseDecodable(of: [HospitalListDTO].self) { response in
            print("alamofire 실행~~")

            switch response.result {
            case .success(let value):
                print("호출 성공 searchHospitalList")
                self.hospitalList = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 searchHospitalList")
            }
        }
    }
}
