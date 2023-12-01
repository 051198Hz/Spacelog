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
        let supabaseClient = SupabaseClient(supabaseURL: URL(string: supabaseURL)!, supabaseKey: supabaseAnonPublicKey)
    }
    
    private var supabaseClient : SupabaseClient!
    private let supabaseURL = "https://knuwpkfcjwgogllrwttv.supabase.co"
    private let supabaseAnonPublicKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtudXdwa2Zjandnb2dsbHJ3dHR2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk4NDc2NDgsImV4cCI6MjAxNTQyMzY0OH0.iDP2EsQCgD28FKC3sLc_uth8C87I5BuZYsYaNZAJKZg"
    
    // MARK: - Supabase storage 이미지 업로드 API 요청
    // 퀄리티는 0.8로 고정
    // 타입은 jpg로 고정
    func uploadImageRequestAPI(image : UIImage) async -> String {
        let fileName = UUID().uuidString + Date().toString()
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
        }
        return fileName
    }
    
    // MARK: - Supabase database 기록 업로드 API 요청


    
}
