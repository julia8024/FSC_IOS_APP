//
//  LoginView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI
import Foundation
import Alamofire

struct LoginView: View {
    
    @ObservedObject var userController = UserController()
    
    // id == 이메일
    @State private var inputUserID: String = ""
    @State private var inputUserPW: String = ""
    
    
    @State private var wrongInput = false
//    @State private var popAlert = false
    
    @Binding var isPresented: Bool
    @Binding var isLogined: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle().frame(height:0)
            Text("로그인").font(.system(size: 24)).fontWeight(.black)
            Spacer().frame(height:70)
            VStack(alignment: .leading) {
                
                UnderlineTextFieldView(text: $inputUserID, textField: idView, placeholder: "아이디를 입력하세요")
                    .padding(.bottom, 32)
                
                UnderlineTextFieldView(text: $inputUserPW, textField: pwView, placeholder: "비밀번호를 입력하세요")
                
            
            }
            
            VStack {
                
                if (wrongInput) {
                    Text("아이디나 비밀번호가 일치하지 않습니다")
                        .font(.system(size: 14))
                        .foregroundColor(Color("redPointColor"))
                }
            }
            .padding(.bottom, 70)
            
            Button {
                if (inputUserID != "" && inputUserPW != "") {
                    userController.login(loginDTO: LoginDTO(user_email: inputUserID, user_password: inputUserPW))
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
                      // 0.5초 후 실행될 부분
                        user = userController.userData
                        isLogined = userController.returnIsLogin
                        isPresented = userController.returnIsPresented
                        if (userController.returnIsLogin == false) {
                            wrongInput = true
                        }
                    }
                    
                } else {
                    wrongInput = true
                }
            } label: {
                Text("로그인")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 20)
            .background(Color("mainColor"))
            .cornerRadius(16)
            
            
//            .alert(isPresented: $popAlert) {
//                Alert(title: Text("로그인 완료!"), message: nil,
//                                  dismissButton: .default(Text("확인")))
//            }
            
        }
        .padding(30)
        .onDisappear() {
            isPresented = false
        }

        
    }
}

extension LoginView {
    private var idView: some View {
        TextField("", text: $inputUserID)
           .font(.system(size:16))
           .disableAutocorrection(true)
           .textInputAutocapitalization(.never)
    }
    
    private var pwView: some View {
        SecureField("", text: $inputUserPW)
           .font(.system(size:16))
           .disableAutocorrection(true)
           .textInputAutocapitalization(.never)
    }
}
