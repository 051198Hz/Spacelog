//
//  APIManager.swift
//  spacelog_MVVM
//
//  Created by iOS Dev on 2023/12/01.
//

import Foundation
import Supabase
import UIKit

class APIManager{
    // MARK: - supabase, 기타 서버 API통신 관련 싱글톤 클래스
    static let sharedInstance = APIManager()
    
    init(){
        supabaseClient = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseAnonPublicKey)
    }
    let naverClientID = "n6q7ir9vtp"
    private var supabaseClient : SupabaseClient!
    private let supabaseURL = "https://knuwpkfcjwgogllrwttv.supabase.co"
    private let supabaseAnonPublicKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtudXdwa2Zjandnb2dsbHJ3dHR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk4NDc2NDgsImV4cCI6MjAxNTQyMzY0OH0.iDP2EsQCgD28FKC3sLc_uth8C87I5BuZYsYaNZAJKZg"
    
    // MARK: - Supabase storage 이미지 업로드 요청 API
    // 퀄리티는 0.8로 고정
    // 타입은 jpg로 고정
    func uploadImageRequestAPI(image : UIImage) async -> String? {
        let fileName = UUID().uuidString + "_" + Date().toString()
        let FileExtension = ".jpg"
        let fileData = image.jpegData(compressionQuality: 0.8)!
        
        do {
            let result = try await supabaseClient.storage
                .from("spacelog-image")
                .upload(
                    path: "\(fileName)\(FileExtension)",
                    file: fileData,
                    options: FileOptions(cacheControl: "3600",contentType: "image/jpeg")
                )
        }catch{
            print(error)
            return nil
        }
        return fileName
    }
    
    // MARK: - Supabase database 기록 업로드 요청 API
    func uploadPostingRequestAPI(posting : SpaceLogPosting?, image : UIImage) async{
        var posting = posting
        guard let imagename = await uploadImageRequestAPI(image: image) else{
            print("Failed to upload image")
            return
        }
        
        posting?.image_name = imagename
        
        do{
            let result3 = try await supabaseClient.database
                .from("Logs")
                .insert(posting)
                .execute()
        }catch{
            print(error)
            print("Failed to upload post")
            return
        }
        print("upload success")
    }
    
    // MARK: - Supabase database 기록 다운로드 요청 API
    func downloadPostingRequestAPI() async ->  [SpaceLogPosting]{
        var postings = [SpaceLogPosting]()
        do{
            postings = try await supabaseClient.database
              .from("Logs")
              .select()
              .execute()
              .value
        }catch{
            print(error)
        }
        
        return postings
    }
    
    
    // MARK: - Supabase storage 이미지 다운로드 요청 API
    func downloadImageRequestAPI(imageURL : String, _ frameSize : CGRect?) async -> Data? {
        
        var file : Data?
        do{
            if let frameSize{
                file = try await supabaseClient.storage
                  .from("spacelog-image")
                  .download(path: "user-1212/"+imageURL, options: TransformOptions(width: Int(frameSize.width), height: Int(frameSize.height), resize: "fill"))
            }else{
                file = try await supabaseClient.storage
                  .from("spacelog-image")
                  .download(path: "user-1212/"+imageURL )
            }
        }catch{
            print(error)
            print("Failed to download image")
            return nil
        }
        print(file)
        return file
    }
    
    // MARK: - Supabase storage 이미지 다운로드 요청 API
    func downloadImageRequestAPI(imageURL: String) async -> Data? {
        
        var file : Data?
        do{
                file = try await supabaseClient.storage
                  .from("spacelog-image")
                  .download(path: "user-1212/"+imageURL )
        
        }catch{
            print(error)
            print("Failed to download image")
            return nil
        }
        print(file)
        return file
    }
    
}
