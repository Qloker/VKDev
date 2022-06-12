//
//  Group.swift
//  vk-ilia
//
//  Created by Ilia Zakharov on 08.05.2022.
//

//   let groupsResponse = try? newJSONDecoder().decode(GroupsResponse.self, from: jsonData)

import Foundation


// MARK: - GroupsResponse
struct GroupsResponse: Codable {
    let response: ResponseGroup
}

// MARK: - Response
struct ResponseGroup: Codable {
    let count: Int
    let items: [Group]
}

// MARK: - Item
struct Group: Codable {
    let id, isClosed, isAdvertiser: Int
    let itemDescription, type: String
    let isMember: Int
    let photo50, photo200: String
    let isAdmin: Int
    let photo100: String
    let name, screenName: String

    enum CodingKeys: String, CodingKey {
        case id
        case isClosed = "is_closed"
        case isAdvertiser = "is_advertiser"
        case itemDescription = "description"
        case type
        case isMember = "is_member"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case isAdmin = "is_admin"
        case photo100 = "photo_100"
        case name
        case screenName = "screen_name"
    }
}
