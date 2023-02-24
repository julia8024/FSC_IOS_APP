//
//  DiagnosisView.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import SwiftUI

struct DiagnosisView: View {
    
    @ObservedObject var hospitalController = HospitalController()
    @ObservedObject var diagnosisController = DiagnosisController()
    
    @State var showImagePicker: Bool = false
    @State var image: Image? = nil
    
    @State var diagnosisStatus = false
    
    var body: some View {
        VStack {
            
            VStack {
                Text("AI 진단")
                    .font(.system(size: 32))
                    .fontWeight(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 30)
            .padding(.top, 30)
            .padding(.bottom, 0)
            
            ScrollView {
                
                VStack {
                    
                    ZStack{
                        if (image == nil) {
                            VStack {
                                Spacer()
                                Image(systemName: "camera")
                                    .environment(\.symbolVariants, .none)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("mainPointColor"))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .aspectRatio(1.0, contentMode: .fill)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20).fill()
                                    .foregroundColor(Color("mainBrightColor"))
                            )
                        } else {
                            image?
                                .resizable()
                                .aspectRatio(1.0, contentMode: .fill)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .clipped() //프레임을 벗어나는 이미지 제거
                        }
                        
                        VStack {
                            Spacer()
                            Button(action: {
                                self.showImagePicker.toggle()
                            }) {
                                Image(systemName: "camera")
                                    .environment(\.symbolVariants, .none)
                                    .font(.system(size: 24))
                                    .foregroundColor(Color("mainPointColor"))
                            }
                            Spacer()
                        }
                    } // zstack
                    .padding(.horizontal, 30)
                    
                }
                .padding(.bottom, 30)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(sourceType: .photoLibrary) { image in
                        self.image = Image(uiImage: image)
                    }
                }
                
                if (diagnosisStatus == true) {
                    Text("\(getDiagName(diag_type: diagnosisController.diagResult.diag_type))일 확률")
                        .font(.system(size: 16))
                        .fontWeight(.bold)

                    Text("\(diagnosisController.diagResult.diag_percent)%")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                        .foregroundColor(Color("bluePointColor"))
                        .padding(.bottom, 20)

                    Text("본 진단은 정확하지 않을 수 있으므로,\n정확한 진단을 위해 병원에 방문하시길 바랍니다.")
                        .font(.system(size: 14))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("grayTextColor"))
                        .padding(.bottom, 40)
                    
                }
                
                Button {
                    diagnosisStatus = true
                    diagnosisController.uploadFile(diag_image: resizeImage(image: image?.asUIImage() ?? UIImage(), newWidth: 300))
//                    diagnosisController.uploadFile(diag_image: image?.asUIImage())
                } label: {
                    Text("진단 시작하기")
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 20)
                .background(Color("mainColor"))
                .cornerRadius(16)
                
                
                
            }
            .padding(30)
            
        }
        .refreshable {
            self.diagnosisStatus = false
        }
        
    } // body
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.draw(in: CGRectMake(0, 0, newWidth, newHeight))
        guard let newImage = UIGraphicsGetImageFromCurrentImageContext() else { return image }
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func getDiagName(diag_type: Int) -> String {
        var typeList = ["Actinic keratoses", "Basal cell carcinoma", "Benign keratosis-like lesions", "Dermatofibroma", "Melanoma", "Melanocytic nevi", "Vascular lesions", ""]
        return typeList[diag_type]
    }
    
}


extension View {
// This function changes our View to UIView, then calls another function
// to convert the newly-made UIView to a UIImage.
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
// here is the call to the function that converts UIView to UIImage: `.asUIImage()`
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
// This is the function to convert UIView to UIImage
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

