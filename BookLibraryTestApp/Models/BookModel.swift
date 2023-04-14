//
//  Book.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation

struct BooksListResponse: Codable {
    let works: [Book]
}

struct Book: Codable {
    let key: String
    let title: String
    let authors: [Author]?
    let firstPublishYear: Int?
    let cover_id: Int?

    enum CodingKeys: String, CodingKey {
        case key
        case title
        case authors
        case firstPublishYear = "first_publish_year"
        case cover_id
    }
}

struct Author: Codable {
    let key: String
    let name: String
}
