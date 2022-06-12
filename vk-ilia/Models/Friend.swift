//
//  Friend.swift
//  vk-ilia
//
//  Created by Artur Igberdin on 13.04.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//


import Foundation

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Friend]
}

// MARK: - Item
struct Friend: Codable {
    let id: Int
    let isClosed: Bool?
    let sex: Int?
    let trackCode: String?
    let canAccessClosed: Bool?
    let domain, firstName: String?
    let city: City?
    let photo50: String?
    let lastName, nickname: String?
    let country: City?
    let bdate: String?

    enum CodingKeys: String, CodingKey {
        case id
        case isClosed = "is_closed"
        case sex
        case trackCode = "track_code"
        case canAccessClosed = "can_access_closed"
        case domain
        case firstName = "first_name"
        case city
        case photo50 = "photo_50"
        case lastName = "last_name"
        case nickname, country, bdate
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let title: String
}
