//
//  ApplicationEndpoints.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

enum ApplicationEndpoints {
    case getApplications
    case getApplication(id: Int)
    case createApplication(CreateApplicationRequest)
}

extension ApplicationEndpoints: TargetType {
    var baseURL: URL {
        URL(string: "https://4f81bf9a10f9.ngrok-free.app")!
    }
    
    var path: String {
        switch self {
        case .getApplications:
            return "/application/"
        case .getApplication(let id):
            return "/application/\(id)/"
        case .createApplication:
            return "/application/"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getApplications, .getApplication:
            return .get
        case .createApplication:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getApplications, .getApplication:
            return .requestPlain
        case .createApplication(let request):
            return .requestJSONEncodable(request as! Encodable)
        }
    }
    
    var headers: [String: String]? {
        return ["accept": "application/json"]
    }
}
