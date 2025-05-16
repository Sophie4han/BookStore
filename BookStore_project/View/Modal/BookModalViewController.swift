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
        stack.distribution = .fill
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
        bookAuthor.font = .systemFont(ofSize: 15)
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
        price.font = .systemFont(ofSize: 20)
        return price
    }()
    
    let contents: UILabel = {
        let bookContents = UILabel()
        bookContents.numberOfLines = 0
        bookContents.setContentHuggingPriority(.defaultLow, for: .vertical) // 공간이 있다면 아래로 쭉쭉
        bookContents.setContentCompressionResistancePriority(
            .required, for: .vertical) // 텍스트가 잘릴 일 없음
        return bookContents
    }()
    
    let xButton: UIButton = {
        let xBtn = UIButton()
        xBtn.setImage(UIImage(named: "close"), for: .normal)
        xBtn.imageView?.contentMode = .scaleAspectFit
        xBtn.clipsToBounds = true
        xBtn.backgroundColor = .lightGray
        xBtn.layer.cornerRadius = 13
//        xBtn.setContentHuggingPriority(.defaultLow, for: .horizontal)
        xBtn.addTarget(self, action: #selector(xTapped), for: .touchUpInside)
        return xBtn
    }()
    
    let addButton: UIButton = {
        let add = UIButton()
        add.setTitle("담기", for: .normal)
        add.setTitleColor(.white, for: .normal)
        add.backgroundColor = .green
        add.layer.cornerRadius = 13
//        add.setContentHuggingPriority(.defaultHigh, for: .horizontal)
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
        stack.distribution = .fill
        return stack
    }()

    
    weak var delegate: BookModalViewControllerDelegate?
    var selectIndex: Int?
    var bookCart: BookData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [/*xButton, addButton, */backgroundVIew, infoScroll].forEach({view.addSubview($0)})
        
        infoScroll.addSubview(infoStack)
        
        [titleInfo, author, thumbnail, bookPrice, contents].forEach({infoStack.addArrangedSubview($0)})
        
        backgroundVIew.addSubview(buttonStack)
        [xButton, addButton].forEach { buttonStack.addArrangedSubview($0) }
        
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
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
            $0.top.bottom.equalTo(infoScroll.contentLayoutGuide).inset(50)
            $0.width.equalTo(infoScroll.frameLayoutGuide).inset(20)
            $0.leading.trailing.equalTo(infoScroll.contentLayoutGuide).inset(20)
        }

        thumbnail.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.7)
            $0.height.equalTo(thumbnail.snp.width).multipliedBy(1.4)
            $0.top.equalTo(author.snp.bottom).offset(20)
        }
        
        bookPrice.snp.makeConstraints {
            $0.top.equalTo(thumbnail.snp.bottom).offset(20)
        }

        backgroundVIew.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(80)
        }

        buttonStack.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
        
        contents.snp.makeConstraints {
            $0.top.equalTo(bookPrice.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        xButton.snp.makeConstraints {
            $0.width.equalTo(90)
        }
        
        addButton.snp.makeConstraints {
            $0.width.equalTo(130)
        }
        

    }
    
    @objc func xTapped() {
        dismiss(animated: true) // 닫음
    }
    
    @objc func addTapped() {
        let moveToCart = AddViewController()
        guard let book = bookCart else { return }
        BookCartManager.cart(book: book) // 모달 쪽에서도 연결해줘야 카트 뷰컨에서 반영됩
        
        dismiss(animated: true)
//        moveToCart.data = [book]
//        let push = UINavigationController(rootViewController: moveToCart)
//        self.present(push, animated: true)
    }
    
    
    func setData(data: BookData) {
        
        self.bookCart = data
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
