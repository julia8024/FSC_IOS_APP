//
//  DiagnosisController.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/22.
//

import Foundation
import Alamofire
import SwiftUI

class DiagnosisController: ObservableObject {
    
//    @Published var image: UIImage?
//    var data: Data?
    
    @Published var diagResult = DiagResult()
    @Published var diagResultforList = DiagResult()
    @Published var diagnosisList = [DiagnosisListDTO]()
    
    func uploadFile(diag_image : UIImage?) {
        
        let url = host + "/diagnosis/upload-diagnosis"
        
        let header : HTTPHeaders = [
            "Content-Type": "multipart/form-data"
        ]
        
        let parameters: [String: Any] = [
//            "diag_image": diag_image,
            "user_id": user.user_id
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            if let image = diag_image?.pngData() {
                multipartFormData.append(image, withName: "diag_image", fileName: "\(image).png", mimeType: "image/png")
            }
        }, to: url, method: .post, headers: header).responseDecodable(of:DiagResult.self) { response in
            switch response.result {
            case .success(let value):
                print("호출 성공 uploadFile")
                self.diagResult = value
                
            case .failure(_):
                print("호출 실패 uploadFile")
                print(response.result)
            }
        }
                  
    }
    
    func getDiagnosisList() {
        let url = host + "/diagnosis/diagnosis-list/" + String(user.user_id)
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "GET"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of:[DiagnosisListDTO].self) { response in
            switch response.result {
            case .success(let value):
                print("호출 성공 getDiagnosisList")
                self.diagnosisList = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 getDiagnosisList")
            }
        }
        
    }
    
    func getDiagResult(diag_id: Int) {
        let url = host + "/diagnosis/diagresult/" + String(diag_id)
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "GET"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of:DiagResult.self) { response in
            switch response.result {
            case .success(let value):
                print("호출 성공 getDiagResult")
                self.diagResultforList = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 getDiagResult")
            }
        }
    }
    
}
