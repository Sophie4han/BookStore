//
//  ModalViewController.swift
//  BookStore_project
//
//  Created by Sophie on 5/11/25.
//

protocol BookModalViewControllerDelegate: AnyObject {
    func chooseBook(_ book: BookData)
}

import UIKit
import SnapKit

class BookModalViewController: UIViewController {
    
    
    let infoScroll: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    let titleInfo: UILabel = {
        let bookTitle = UILabel()
        bookTitle.font = .systemFont(ofSize: 20, weight: .bold)
        bookTitle.textColor = UIColor.black
        bookTitle.numberOfLines = 0 // 여러 줄 가능
        return bookTitle
    }()
    
    let author: UILabel = {
        let bookAuthor = UILabel()
        bookAuthor.font = .systemFont(ofSize: 10)
        bookAuthor.textColor = UIColor.black
        return bookAuthor
    }()
    
    let thumbnail: UIImageView = {
        let bookThumbnail = UIImageView()
        bookThumbnail.contentMode = .scaleAspectFit
        bookThumbnail.clipsToBounds = true
        return bookThumbnail
    }()
    
    let bookPrice: UILabel = {
        let price = UILabel()
        price.font = .systemFont(ofSize: 15)
        return price
    }()
    
    let contents: UILabel = {
        let bookContents = UILabel()
        bookContents.numberOfLines = 0
        return bookContents
    }()
    
    let xButton: UIButton = {
        let xBtn = UIButton()
        xBtn.setImage(UIImage(named: "close"), for: .normal)
        xBtn.backgroundColor = .lightGray
        xBtn.layer.cornerRadius = 10
        xBtn.addTarget(self, action: #selector(xTapped), for: .touchUpInside)
        return xBtn
    }()
    
    let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("담기", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = .green
        add.layer.cornerRadius = 10
        add.addTarget(self, action: #selector(addTapped), for: .touchUpInside)
        return add
    }()
    
    let backgroundVIew: UIView = {
        let bg = UIView()
        bg.layer.cornerRadius = 20
        bg.backgroundColor = .white
        return bg
    }()
    
    let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        return stack
    }()

    
    weak var delegate: BookModalViewControllerDelegate?
    var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [/*xButton, addButton, */backgroundVIew, infoScroll].forEach({view.addSubview($0)})
        
        infoScroll.addSubview(infoStack)
        
        [titleInfo, author, thumbnail, bookPrice, contents].forEach({infoStack.addArrangedSubview($0)})
        
        backgroundVIew.addSubview(buttonStack)
        [addButton, xButton].forEach { buttonStack.addArrangedSubview($0) }
        
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.masksToBounds = true
        setConstraints()
    }
    
    func setConstraints() {
        
        infoScroll.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(backgroundVIew.snp.top).offset(-10)
        }

        infoStack.snp.makeConstraints {
            $0.top.bottom.equalTo(infoScroll.contentLayoutGuide)
            $0.width.equalTo(infoScroll.frameLayoutGuide).inset(20)
        }

        thumbnail.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(thumbnail.snp.width).multipliedBy(1.2)
        }

        backgroundVIew.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }

        buttonStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }

    }
    
    @objc func xTapped() {
        dismiss(animated: true) // 닫음
    }
    
    @objc func addTapped() {
        let moveToCart = AddViewController()
        navigationController?.pushViewController(moveToCart, animated: true)
    }
    
    
    func setData(data: BookData) {
        
        titleInfo.text = data.title
        author.text = data.authors.first ?? ""
        contents.text = data.contents
        bookPrice.text = "\(data.price)"
        
        let thumbnailUrl = data.thumbnail
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: thumbnailUrl) {
                let thumbnailImage = UIImage(data: imageData)
                
                DispatchQueue.main.async {
                    self.thumbnail.image = thumbnailImage
                }
            }
        }
    }
}
