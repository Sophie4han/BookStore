//
//  Untitled.swift
//  BookStore_project
//
//  Created by Sophie on 5/11/25.
//

import Foundation

struct BookStoreData: Codable {
    let documents: [BookData]
}

struct BookData: Codable {
    let title: String
    let contents: String
    let authors: [String]
    let thumbnail: URL
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case title
        case contents
        case authors
        case thumbnail
        case price
    }
    
}
