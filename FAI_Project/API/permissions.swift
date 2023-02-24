//
//  permissions.swift
//  FAI_Project
//
//  Created by 장세희 on 2023/02/20.
//

import Foundation
import AVFoundation
import Photos


// 카메라 접근 권한 허용
func checkCameraPermission(){
   AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
       if granted {
           print("Camera: 권한 허용")
       } else {
           print("Camera: 권한 거부")
       }
   })
}

// 앨범 접근 권한 허용
func checkAlbumPermission(){
    PHPhotoLibrary.requestAuthorization( { status in
        switch status{
        case .authorized:
            print("Album: 권한 허용")
        case .denied:
            print("Album: 권한 거부")
        case .restricted, .notDetermined:
            print("Album: 선택하지 않음")
        default:
            break
        }
    })
}
