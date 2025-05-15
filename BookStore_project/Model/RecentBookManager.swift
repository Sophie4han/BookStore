//
//  RecentBookManager.swift
//  BookStore_project
//
//  Created by Sophie on 5/13/25.
//

import Foundation

class RecentBookManager {
        
        static let key = "recentBooks"
    
        static var savedBooks: [BookData] {
        
        get {
            guard let savedData = UserDefaults.standard.data(
                forKey: key) else { return [] }
            return (try? JSONDecoder().decode([BookData].self, from: savedData)) ?? []
        }
        set {
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func add(book: BookData) {
        
        var showBooks = savedBooks
        showBooks.removeAll{ $0.title == book.title }
        showBooks.insert(book, at: 0)
        savedBooks = Array(showBooks.prefix(10))
        
    }
}
