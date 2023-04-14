//
//  BookDetailModel.swift
//  BookLibraryTestApp
//
//  Created by Evgeny on 13.04.23.
//

import Foundation

struct BookDetail: Codable {
    let description: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case description
        case title
    }
}
