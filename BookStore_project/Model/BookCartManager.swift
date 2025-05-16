//
//  BookCartManager.swift
//  BookStore_project
//
//  Created by Sophie on 5/16/25.
//

import Foundation

class BookCartManager {
    
    static let key = "bookCart"
    
    static var savedBooks2: [BookData] {
        
        get {
            guard let savedData =
                    UserDefaults.standard.data(
                        forKey: key) else { return[] }
            return (try? JSONDecoder().decode([BookData].self, from: savedData)) ?? []
        }
        set {
            let encoded = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    static func cart(book: BookData) {
        
        var saveBooks = savedBooks2
        saveBooks.removeAll() {$0.title == book.title }
        saveBooks.insert(book, at: 0) // 새 책은 맨 앞에
        
        if saveBooks.count > 10 {
            savedBooks2.removeLast()
        }
        
        savedBooks2 = saveBooks
        
    }
}
