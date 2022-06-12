//
//  Photos.swift
//  vk-app
//
//  Created by Ilia Zakharov on 28.04.2022.
//

import Foundation

// MARK: - PhotosResponse
struct PhotosResponse: Codable {
    let response: ResponsePh
}

// MARK: - Response

struct ResponsePh: Codable {
    let count: Int
    let items: [Photo]
  
}

// MARK: - Item
struct Photo: Codable {
    let albumID, id, date: Int?
    let text: String?
    let realOffset: Int?
    let sizes: [Size]?
    let hasTags: Bool?
    let ownerID: Int

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case realOffset = "real_offset"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
