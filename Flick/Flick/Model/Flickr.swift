//
//  Flickr.swift
//  Flick
//
//  Created by Luann Luna on 25/03/24.
//

import Foundation

// MARK: - Flickr
struct FlickrResponse: Codable {
    let title: String
    let link: String
    let description: String
    let modified: String
    let generator: String
    let items: [Thumb]
}

// MARK: - Item
struct Thumb: Codable, Identifiable {
    let id = UUID()
    let title: String
    let link: String
    let media: Media
    let dateTaken: String
    let description: String
    let published: String
    let author, authorID, tags: String

    enum CodingKeys: String, CodingKey {
        case title, link, media
        case dateTaken = "date_taken"
        case description, published, author
        case authorID = "author_id"
        case tags
    }
}

// MARK: - Media
struct Media: Codable {
    let m: String
}
