//
//  HeadersVIew.swift
//  BookStore_project
//
//  Created by Sophie on 5/13/25.
//

import UIKit

class SearchResultHeader: UICollectionReusableView {
    
    static let id = "HeadersVIew"
    
    let searchResult: UILabel = {
        let search = UILabel()
        search.text = "검색 결과"
        search.textColor = .black
        search.font = .systemFont(ofSize: 20, weight: .bold)
        return search
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        [searchResult].forEach({addSubview($0)})
        
        searchResult.frame.origin = CGPoint(x: 10, y: 0)
        searchResult.sizeToFit()
//        searchResult.isHidden = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
