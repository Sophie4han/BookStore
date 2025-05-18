//
//  RecentBookManager.swift
//  BookStore_project
//
//  Created by Sophie on 5/13/25.
//

import Foundation

class RecentBookManager {
        
        static let key = "recentBooks"
    /*
     계산 프로퍼티에서 get, set
     savedBook = data를 넣으면 set 실행된다
     savedBook라는 프로퍼티를 가져오면 get이 실행된다
     */
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
//        savedBooks = Array(showBooks.prefix(10)) // 열개가 고정 값으로 뜸
        
        if showBooks.count > 8 {
            savedBooks.removeLast()
        }
        
        // savedBooks에다가 showBooks를 넣어줌
        // set이 실행됨
        // = UserDefaults에 저장하는 코드 실행
        savedBooks = showBooks
        
    }
}
