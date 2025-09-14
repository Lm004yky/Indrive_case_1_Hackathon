//
//  DownloadDestination.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

public typealias DownloadDestination = (URL, HTTPURLResponse) -> URL

public struct DownloadRequest {
    public static func suggestedDownloadDestination(
        for directory: FileManager.SearchPathDirectory = .documentDirectory,
        in domain: FileManager.SearchPathDomainMask = .userDomainMask
    ) -> DownloadDestination {
        return { temporaryURL, response in
            let directoryURLs = FileManager.default.urls(for: directory, in: domain)
            
            if !directoryURLs.isEmpty {
                return directoryURLs[0].appendingPathComponent(response.suggestedFilename!)
            }
            
            return temporaryURL
        }
    }
}
