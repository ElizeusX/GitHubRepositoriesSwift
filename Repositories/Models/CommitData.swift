//
//  CommitData.swift
//  Repositories
//
//  Created by Elizeus on 11/06/2020.
//  Copyright © 2020 Elizeus. All rights reserved.
//


import Foundation

enum EncodingError: Error{
    case invalidDate
}
 

// MARK: - Commit
struct CommitItem: Decodable {
    let sha: String
    let nodeID: String
    let commit: Commit
    let url: String
    let htmlURL: String
    let commentsURL: String
    let author: CommitAuthor?
    let committer: CommitAuthor?
    let parents: [Parent]

    enum CodingKeys: String, CodingKey {
        case sha
        case nodeID = "node_id"
        case commit
        case url
        case htmlURL = "html_url"
        case commentsURL = "comments_url"
        case author
        case committer
        case parents
    }
}

// MARK: - CommitAuthor
struct CommitAuthor: Codable {
    let login: String
    let id: Double
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let url: String
    let htmlURL: String
    let followersURL: String
    let followingURL: String
    let gistsURL: String
    let starredURL: String
    let subscriptionsURL: String
    let organizationsURL: String
    let reposURL: String
    let eventsURL: String
    let receivedEventsURL: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

// MARK: - Commit
struct Commit: Decodable {
    let author: CommitAuthorClass
    let committer: CommitAuthorClass
    let message: String
    let tree: Tree
    let url: String
    let commentCount: Int
    let verification: Verification

    enum CodingKeys: String, CodingKey {
        case author
        case committer
        case message
        case tree
        case url
        case commentCount = "comment_count"
        case verification
    }
}

// MARK: - CommitAuthorClass
struct CommitAuthorClass: Decodable {
    let name: String
    let email: String
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case email
        case name
    }
    init(name: String, email: String, date: String){
        self.name = name
        self.email = email
        self.date = date
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        let originalDate = try container.decode(String.self, forKey: .date)
        let dataService = DateService()
        guard let date: Date = dataService.convert(from: originalDate) else{
            throw EncodingError.invalidDate
        }
        guard let formatedDate: String = dataService.convert(from: date) else{
            throw EncodingError.invalidDate
        }
        self.date = formatedDate
    }
     func copy(date: String) -> CommitAuthorClass{
        return CommitAuthorClass(name: name, email: email, date: date)
    }
}

// MARK: - Tree
struct Tree: Codable {
    let sha: String
    let url: String
}

// MARK: - Verification
struct Verification: Codable {
    let verified: Bool
    let reason: String
    let signature: JSONNull?
    let payload: JSONNull?
}

// MARK: - Parent
struct Parent: Codable {
    let sha: String
    let url: String
    let htmlURL: String

    enum CodingKeys: String, CodingKey {
        case sha
        case url
        case htmlURL = "html_url"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
