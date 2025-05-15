//
//  SearchResultCell.swift
//  BookStore_project
//
//  Created by Sophie on 5/12/25.
//

import UIKit
import SnapKit

protocol SearchResultCellDelegate: AnyObject {
    func didTapSearchResult(Book: BookData)
}

class SearchResultCell: UICollectionViewCell {
    
    static let id = "SearchResultCell"
    weak var delegate: SearchResultCellDelegate?
    
    let bookTitle: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 15)
        return title
    }()
    
    let bookAuthor: UILabel = {
        let author = UILabel()
        author.font = .systemFont(ofSize: 10)
        author.textColor = .lightGray
        return author
    }()
    
    let bookPrice: UILabel = {
        let price = UILabel()
        price.font = .systemFont(ofSize: 10)
        return price
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        [bookTitle, bookAuthor, bookPrice].forEach({contentView.addSubview($0)})
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func dataConnect(data: BookData) {
        bookTitle.text = data.title
        bookAuthor.text = data.authors.first ?? ""
        bookPrice.text = "\(data.price)" // Int -> String
    }
    
}
