//
//  EditUserInfoView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/21.
//

import SwiftUI


struct EditUserInfoView: View {
    
    @ObservedObject var userController = UserController()
    
    @Binding var isPresented: Bool
    
    @State var inputUserName: String = user.user_name
    @State var inputPW: String = ""
    @State var inputPWChk: String = ""
    
    @State private var textMsg = true
    @State private var textWrongPW = true
    
    var body: some View {
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Text("이름").font(.system(size:16)).foregroundColor(Color("mainPointColor"))
                    .fontWeight(.bold)
                UnderlineTextFieldView(text: $inputUserName, textField: nameView, placeholder: "이름을 입력하세요")
                    .padding(.bottom, 32)
                
                Text("비밀번호").font(.system(size:16)).foregroundColor(Color("mainPointColor"))
                    .fontWeight(.bold)
                UnderlineTextFieldView(text: $inputPW, textField: passwordView, placeholder: "비밀번호를 입력하세요")
                    .padding(.bottom, 32)
                
                Text("비밀번호 확인").font(.system(size:16)).foregroundColor(Color("mainPointColor"))
                    .fontWeight(.bold)
                UnderlineTextFieldView(text: $inputPWChk, textField: passwordChkView, placeholder: "비밀번호를 다시 입력하세요")
                    .padding(.bottom, 32)
            }
            
            VStack {
                if (!textWrongPW) {
                    Text("비밀번호가 서로 일치하지 않습니다").font(.system(size: 14))
                        .foregroundColor(Color("redPointColor"))
                        .padding(.bottom, 20)
                    
                }
                
                if (!textMsg) {
                    Text("모든 칸을 필수로 입력해주세요").font(.system(size: 14))
                        .foregroundColor(Color("redPointColor"))
                }

            }
            
        } // scrollView
        .padding(.top, 30)
        .padding(.horizontal, 30)
        .navigationTitle("정보 수정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(leading: Button(action: {
            self.isPresented = false
        }, label: {
            Text("취소")
        }), trailing: Button(action: {
            if (inputUserName == "" || inputPW == "" || inputPWChk == "") {
                // 하나라도 빈칸이 있는 경우
                textMsg = false
            } else if (inputPW != inputPWChk && inputPW != "") {
                textWrongPW = false
            } else {
                userController.editUserInfo(editUser: User(user_email: user.user_email, user_name: inputUserName, user_password: inputPW))
                self.isPresented = false
            }
        }, label: {
            Text("확인")
        }))
        .onAppear() {
            print("appear editUserInfo ◡̎")
        }
        .onDisappear() {
            print("disappear editUserInfo ◡̎")
        }
        .background(Color("bgMainColor"))
        
    } // body
}


extension EditUserInfoView {

    private var nameView: some View {
         TextField("", text: $inputUserName)
            .font(.system(size:16))
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }

     private var passwordView: some View {
          SecureField("", text: $inputPW)
             .font(.system(size:16))
             .disableAutocorrection(true)
             .textInputAutocapitalization(.never)
     }
    
    private var passwordChkView: some View {
         SecureField("", text: $inputPWChk)
            .font(.system(size:16))
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }
}
