//
//  SearchBar.swift
//  BookStore_project
//
//  Created by Sophie on 5/10/25.
//

import UIKit
import SnapKit

class SearchBar: UISearchBar, UISearchBarDelegate {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUp() {
        
        backgroundColor = .white
        self.delegate = self
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.placeholder = "Search .."
//        self.setImage(UIImage(named: "180"), for: .search, state: .normal)
        
        
        // searchField 비공식 속성이라 self로 직접 접근은 안된다고 함
        // 그래서 key-value코딩 해야한다고 함
        guard let searchArea  = self.value(forKey: "searchField") as? UITextField else { return }
        
        searchArea.backgroundColor = .white
        searchArea.leftView = nil
        searchArea.leftViewMode = .never
        
        let icon = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        icon.contentMode = .scaleAspectFill
        icon.tintColor = .darkGray
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        searchArea.rightView = icon
        searchArea.rightViewMode = .always
        
    }
    
}
