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
        title.font = .systemFont(ofSize: 19, weight: .bold)
        return title
    }()
    
    let bookPrice: UILabel = {
        let price = UILabel()
        price.font = .systemFont(ofSize: 15)
        return price
    }()
    
    let bookAuthor: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 15)
        author.textColor = .darkGray
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
            $0.top.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(15)
        }
        
        bookAuthor.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
//            $0.centerX.equalToSuperview()
        }
        
        bookPrice.snp.makeConstraints {
            $0.top.equalTo(bookTitle.snp.bottom).offset(10)
            $0.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(data: BookData) {
        
        bookTitle.text = data.title
        bookAuthor.text = data.authors.first ?? ""
        bookPrice.text = "\(data.price)"
    }
    
    
}
