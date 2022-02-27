//
//  Photos.swift
//  Image Search
//
//  Created by Alex Paul on 2/25/22.
//

import Foundation
struct PhotoResponse:Codable {
    let data: [PhotoModel]
}

struct PhotoModel:Codable {
    let title: String?
    let views: Int
    let images: [Image]?
    enum CodingKeys: String, CodingKey {
        case title
        case views
        case images
    }
}

struct Image: Codable {
    let link: String?
    enum CodingKeys: String, CodingKey {
        case link
    }
}
