//
//  RecentlyViewedHeader.swift
//  BookStore_project
//
//  Created by Sophie on 5/13/25.
//

import UIKit

class RecentlyViewedHeader: UICollectionReusableView {
    
    static let id = "RecentlyViewedHeader:"
    
    let recentlyRead: UILabel = {
        let recent = UILabel()
        recent.text = "최근 본 책"
        recent.textColor = .black
        recent.font = .systemFont(ofSize: 20, weight: .bold)
        return recent
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(recentlyRead)
        recentlyRead.frame.origin = CGPoint(x: 10, y: 0)
        recentlyRead.sizeToFit()
        recentlyRead.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
