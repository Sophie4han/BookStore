//
//  AddCell.swift
//  BookStore_project
//
//  Created by Sophie on 5/14/25.
//

import UIKit
import SnapKit

class AddCell:  UITableViewCell {
    
    static let id = "AddCell"
    
    let bookTitle: UILabel = {
        let title = UILabel()
        return title
    }()
    
    let bookPrice: UILabel = {
        let price = UILabel()
        return price
    }()
    
    let bookAuthor: UILabel = {
        let author = UILabel()
        return author
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [bookTitle, bookPrice, bookAuthor].forEach({contentView.addSubview($0)})
        setConstraints()
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
    
    func setConstraints() {
        
        bookTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        bookAuthor.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalTo(bookTitle.snp.trailing).offset(10)
        }
        
        bookPrice.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func configure(data: BookData) {
        
        bookTitle.text = data.title
        bookAuthor.text = data.authors.first ?? ""
        bookPrice.text = "\(data.price)"
    }
    
    
}
