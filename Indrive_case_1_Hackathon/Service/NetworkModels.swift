//
//  NetworkModels.swift
//  Indrive_case_1_Hackathon
//
//  Created by Ykylas Nurkhan on 14.09.2025.
//

import Foundation

// MARK: - Application Models
struct ApplicationResponse: Codable {
    let previous: String?
    let next: String?
    let count: Int
    let results: [Application]
    let pageNumber: Int
    let perPage: Int
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case previous, next, count, results
        case pageNumber = "page_number"
        case perPage = "per_page"
        case totalPages = "total_pages"
    }
}

struct Application: Codable {
    let id: Int
    let iin: String
    let name: String
    let surname: String
    let license: License?
    let carPhotos: [CarPhoto]
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id, iin, name, surname, license, status
        case carPhotos = "car_photos"
    }
}

struct License: Codable {
    let id: Int?
    let validatedIin: String?
    let validatedName: String?
    let validatedSurname: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case validatedIin = "validated_iin"
        case validatedName = "validated_name"
        case validatedSurname = "validated_surname"
    }
}

struct CarPhoto: Codable {
    let id: Int?
    let image: String?
    let problems: Bool?
    let problemList: String?
    
    enum CodingKeys: String, CodingKey {
        case id, image, problems
        case problemList = "problem_list"
    }
}

// MARK: - Create Application Request
struct CreateApplicationRequest: Codable {
    let iin: String
    let name: String
    let surname: String
    let carPhotos: [CarPhoto]
    let license: License
    
    enum CodingKeys: String, CodingKey {
        case iin, name, surname, license
        case carPhotos = "car_photos"
    }
}
