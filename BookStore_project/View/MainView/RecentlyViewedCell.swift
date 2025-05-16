//
//  RecentlyViewedCell.swift
//  BookStore_project
//
//  Created by Sophie on 5/12/25.
//

import UIKit
import SnapKit

protocol RecentlyViewedCellDelegate: AnyObject {
    func didTapRecentlyViewed(Book: BookData)
}

class RecentlyViewedCell: UICollectionViewCell {
    
    static let id = "RecentlyViewedCell"
    var delegate:  RecentlyViewedCellDelegate?
    
    let thumbnail: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = image.frame.width / 2
        image.clipsToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(thumbnail)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has been implemented")
    }
    
    func setConstraints() {
        
        thumbnail.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalTo(40)
        }
    }
    
    func setData(data: BookData) {
        
        let setImage = data.thumbnail
        
        DispatchQueue.global().async {
            if let thumbnailData = try? Data(contentsOf: setImage) {
                let thumbnailImage = UIImage(data: thumbnailData)
                
                DispatchQueue.main.async {
                    self.thumbnail.image = thumbnailImage
                }
            }
            
        }
    }
}
