//
//  ProfileView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI


// MARK: ----ProfileView
struct ProfileView: View {
    
    @ObservedObject var userController = UserController()
    
    @State var editUserInfo: Bool = false
    @State var diagnosisInfo = false
    
    @State private var deleteUserAlert: Bool = false
    
    @State private var inputPasswordForDelUser: String = ""
    @State private var wrongInputUser: Bool = false
    
    init() {
        userController.getUser()
    }
    
    var body: some View {
        VStack {
            
            VStack {
                Text("My 페이지")
                    .font(.system(size: 32))
                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .padding(.bottom, 0)
            
            ScrollView {
                
                // 회원정보 박스
                VStack {
                    ZStack {
                        Text("My Page")
                            .font(.system(size: 18))
                            .foregroundColor(Color("mainPointColor"))
                        HStack {
                            Spacer()
                            Image(systemName: "square.and.pencil")
                                .environment(\.symbolVariants, .none)
                                .font(.system(size: 20))
                                .foregroundColor(Color(UIColor.systemBlue))
                                .onTapGesture {
                                    editUserInfo = true
                                }
                                .fullScreenCover(isPresented: $editUserInfo) {
                                    NavigationView {
                                        EditUserInfoView(isPresented: $editUserInfo)
                                            .navigationBarBackButtonHidden(false)
                                    }
                                }
                        }  // hstack
                    }  // zstack
                    .padding(20)
                    
                    VStack {
                        HStack {
                            Text("이름")
                                .font(.system(size: 14))
//                                .fontWeight(.bold)
                            Spacer()
                            Text(userController.userData.user_name)
                                .foregroundColor(Color("grayTextColor"))
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        HStack {
                            Text("이메일")
                                .font(.system(size: 14))
//                                .fontWeight(.bold)
                            Spacer()
                            Text(userController.userData.user_email)
                                .foregroundColor(Color("grayTextColor"))
                                .font(.system(size: 14))
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                        
                        
                    } // vstack
                    .padding(.bottom, 10)
                    
                } // 회원정보 박스
                .frame(maxWidth: .infinity)
                .background(Color("bgColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color("borderColor"), lineWidth: 1)
                    
                )
                .padding(30)
                
                // 분석 기록 조회 버튼
                ZStack {
                    
                    NavigationLink(destination: DiagnosisInfoView(), isActive: $diagnosisInfo) {
                        EmptyView()
                    } //navigationlink
                    .opacity(0.0)
                    //            .hidden()
                    .buttonStyle(PlainButtonStyle())
                
                    Button {
                        diagnosisInfo = true
                    } label: {
                        VStack {
                            Image(systemName: "stethoscope")
                                .environment(\.symbolVariants, .none)
                                .font(.system(size: 48))
                                .foregroundColor(Color("mainPointColor"))
                                .padding(.bottom, 20)
                                .padding(.top, 20)
                            
                            Text("AI 진단 기록 조회")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color("mainPointColor"))
                                .padding(.bottom, 20)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(Color("bgColor"))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("mainPointColor"), lineWidth: 2)
                            
                        )
                        
                    }
                    .padding(.horizontal, 30)
                    
                    
                }
                
                
                HStack {
                    Button {
                        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            exit(0)
                        }
                    } label: {
                        Text("로그아웃")
                            .font(.system(size: 14))
                            .foregroundColor(Color("grayTextColor"))
                    }
                    .frame(maxWidth: .infinity)
                    
                    Divider()
                    
                    Button {
                        deleteUserAlert.toggle()
                    } label: {
                        Text("회원탈퇴")
                            .font(.system(size: 14))
                            .foregroundColor(Color("grayTextColor"))
                    }
                    .frame(maxWidth: .infinity)
                    .alert("회원탈퇴", isPresented: $deleteUserAlert, actions: {

                        TextField("비밀번호", text: $inputPasswordForDelUser)
                            .font(.system(size: 16))
                            .autocapitalization(.none)
                        
                        Button("탈퇴", role: .destructive, action: {
                            if (inputPasswordForDelUser != "") {
                                userController.deleteUser(userDel: UserDeleteDTO(user_id: user.user_id, user_password: inputPasswordForDelUser))
                                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
//                                    user = cafeController.userData
                                    UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        exit(0)
                                    }
                                }
                            }
                        })
                        Button("취소", role: .cancel, action: {})
                    }, message: {
                        if (wrongInputUser == true) {
                            Text("정말 탈퇴하시겠습니까? (입력 오류)")
                        } else {
                            Text("정말 탈퇴하시겠습니까?")
                        }
                    }) // alert
                } // hstack
                .frame(maxWidth: .infinity)
                .padding(.top, 60)
                .padding(.bottom, 30)
                .padding(.horizontal, 30)
            } // scrollview

        } // vstack
        .background(Color("bgMainColor"))
        .refreshable {
            self.userController.getUser()
            print("새로고침 : \(user)")
        }
//        .onAppear() {
//            print("profile -> userid: \(user.userId), \(user.email)")
//        }
    } // body
    
}
