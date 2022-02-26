//
//  Photos.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import Foundation

// MARK: - PhotoResponse
struct PhotoResponse:Codable {
    let data: [PhotoModel]
}

struct PhotoModel:Codable {
    let id: String
    let title: String?
    let views: Int
    let link: String
    let images: [Image]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case views
        case link
        case images
    }
}

struct Image: Codable {
    let link: String?
    
    enum CodingKeys: String, CodingKey {
        case link
    }
}
