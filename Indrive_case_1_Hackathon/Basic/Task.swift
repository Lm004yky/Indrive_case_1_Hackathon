//
//  Task.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

public enum Task {
    case requestPlain
    case requestData(Data)
    case requestJSONEncodable(Encodable)
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
}
