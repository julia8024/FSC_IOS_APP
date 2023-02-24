//
//  UserController.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import Foundation
import Alamofire

class UserController: ObservableObject {
    
    @Published var userData = User()
    @Published var returnIsLogin = false
    @Published var returnIsPresented = true
    
    @Published var returnIsDeleted = false
//    @Published var userProfile = User()
    
    @Published var responseEmail = ResponseDTO()
    @Published var returnChkEmail = false
    
    // login
    func login(loginDTO: LoginDTO) {
        let url = host + "/user/login"
        
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "POST"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // json 인코더 생성
        let encoder = JSONEncoder()
        
        // json 출력 시 예쁘게 출력
        encoder.outputFormatting = .prettyPrinted
        
        do {
            // json 객체로 변환
            let encodedData = try encoder.encode(loginDTO)
            // Request Body에 json 추가
            request.httpBody = encodedData
            
        } catch {
            print("error")
        }
        
        AF.request(request).responseDecodable(of:User.self) { response in
            switch response.result {
            case .success(let value):
                print("login 성공")
                self.userData = value
                user = value
                self.returnIsLogin = true
                self.returnIsPresented = false
            case .failure(_):
                print(response.result)
                print("login 실패")
                self.returnIsLogin = false
                self.returnIsPresented = true
            }
        }
        
    }
    
    // join
    func join(userJoin: User) {
        
        let url = host + "/user/join"

        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "POST"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // json 인코더 생성
        let encoder = JSONEncoder()
        // json 출력 시 예쁘게 출력
        encoder.outputFormatting = .prettyPrinted

        do {
            // json 객체로 변환
            let encodedData = try encoder.encode(userJoin)
            // Request Body에 json 추가
            request.httpBody = encodedData

        } catch {
            print("error")
        }

        
        AF.request(request).responseDecodable(of:User.self) { response in
            switch response.result {
            case .success(let value):
                print("회원가입 성공")
                
            case .failure(_):
                print(response.result)
                print("회원가입 실패")
            }
        }
    }
    
    // editUserInfo
    func editUserInfo(editUser: User) {
        
        let url = host + "/user/get-user/" + String(user.user_id)
        
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "PUT"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // json 인코더 생성
        let encoder = JSONEncoder()
        
        // json 출력 시 예쁘게 출력
        encoder.outputFormatting = .prettyPrinted
        
        do {
            // json 객체로 변환
            let encodedData = try encoder.encode(editUser)
            // Request Body에 json 추가
            request.httpBody = encodedData
            
        } catch {
            print("error")
        }
        
        AF.request(request).responseDecodable(of:User.self) { response in
            switch response.result {
            case .success(let value):
                print("호출 성공 editUserInfo")
                self.userData = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 editUserInfo")
            }
        }
    }
    
    // getUser
    func getUser() {
        let url = host + "/user/get-user/" + String(user.user_id)
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "GET"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        AF.request(request).responseDecodable(of:User.self) { response in
            switch response.result {
            case .success(let value):
                print("호출 성공 getUser")
                self.userData = value
                user = value
                
            case .failure(_):
                print(response.result)
                print("호출 실패 getUser")
            }
        }
    }
    
    func deleteUser(userDel: UserDeleteDTO) {
        
        let url = host + "/user/get-user/" + String(user.user_id)
        
        // URLRequest 객체 생성 (url 전달)
        var request = URLRequest(url: URL(string: url)!)
        // 메소드 지정
        request.httpMethod = "DELETE"
        // 헤더 정보 설정
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // json 인코더 생성
        let encoder = JSONEncoder()
        
        // json 출력 시 예쁘게 출력
        encoder.outputFormatting = .prettyPrinted
        
        do {
            // json 객체로 변환
            let encodedData = try encoder.encode(userDel)
            // Request Body에 json 추가
            request.httpBody = encodedData
            
        } catch {
            print("error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("회원 탈퇴 성공")
                self.returnIsDeleted = true
                
            case .failure(_):
                print(response.result)
                print("회원 탈퇴 실패")
                self.returnIsDeleted = false
            }
        }
    }
    
//    func checkEmail(userEmail: String) {
//        let url = host + "/user/duplicate/" + userEmail
//        print("중복확인 url: \(url)")
//
//        // URLRequest 객체 생성 (url 전달)
//        var request = URLRequest(url: URL(string: url)!)
//        // 메소드 지정
//        request.httpMethod = "GET"
//        // 헤더 정보 설정
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        AF.request(request).responseDecodable(of:ResponseDTO.self) { response in
//            switch response.result {
//            case .success(let value):
//                print("호출 성공 checkEmail")
//                self.responseEmail = value
//                print(value)
//                if (value.status == 409) {
//                    self.returnChkEmail = false
//                } else {
//                    self.returnChkEmail = true
//                }
//                print("\(self.returnChkEmail), \(value.status)")
//            case .failure(_):
//                print(response.result)
//                print("호출 실패 checkEmail")
//            }
//        }
//
//    }
}

struct ResponseDTO: Codable {
    var status: Int
    var message: String
    
    init() {
        status = 0
        message = ""
    }
}
