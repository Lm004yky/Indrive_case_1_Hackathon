//
//  MultipartFormData.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

public struct MultipartFormData {
    public let name: String
    public let data: Data
    public let fileName: String?
    public let mimeType: String?
    
    public init(name: String, data: Data, fileName: String? = nil, mimeType: String? = nil) {
        self.name = name
        self.data = data
        self.fileName = fileName
        self.mimeType = mimeType
    }
}
