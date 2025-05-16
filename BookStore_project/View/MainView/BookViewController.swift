

import UIKit
import SnapKit
import Alamofire

class BookViewController: UIViewController {
    
    let searchBar = SearchBar()
    
    // collectionSet()은 self가 있어야 하는 인스턴스 메서드라
    // 초기화 전에 사용하려면 lazy var을 써야함
    // 아니면 viewDidLoad 안에서
    // fullCollection.collectionViewLayout = collectionSet() 이렇게 쓰던가..
    lazy var fullCollection = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionSet()
    )
    
    let searchHeader = SearchResultHeader()
    let recentlyHeader = RecentlyViewedHeader()
    
    var recentData = RecentBookManager.savedBooks
    var data = [BookData]() {
        didSet { fullCollection.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        [searchBar, fullCollection]
            .forEach { (view.addSubview($0)) }
        
        fullCollection.backgroundColor = UIColor.white
        fullCollection.delegate = self
        fullCollection.dataSource = self
        view.addSubview(fullCollection)
        
        setConstraints()
        
        fullCollection.register(
            RecentlyViewedCell.self,
            forCellWithReuseIdentifier: RecentlyViewedCell.id)
        fullCollection.register(
            SearchResultCell.self,
            forCellWithReuseIdentifier: SearchResultCell.id)
        
        fullCollection.register(
            SearchResultHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: SearchResultHeader.id)
        
        fullCollection.register(
            RecentlyViewedHeader.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: RecentlyViewedHeader.id)
        
        BookApi().fetchData(query: searchBar.text ?? "") { books in
            DispatchQueue.main.async {
                self.data = books
            }
    }
        
        searchBar.delegate = self

        self.searchBar.setUp()
    }
    
    
    
    func collectionSet() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 1 {
                return self.searchResultSection()
            } else {
                return self.recentlyViewedSection()
            }
        }
    }
    
    func searchResultSection() -> NSCollectionLayoutSection {
        // Item
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // Group
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item])
        
        // Section
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        // Return
        return section
    }
    
    func recentlyViewedSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(60),
            heightDimension: .absolute(60))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(300),
            heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 10, leading: 20, bottom: 10, trailing: 20)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(50)
        )

        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func setConstraints() {
        
        fullCollection.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10.0)
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(-10)
            $0.height.equalTo(70)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
//        recentlyHeader.snp.makeConstraints {
//            $0.top.equalTo(<#T##other: any ConstraintRelatableTarget##any ConstraintRelatableTarget#>)
//        }
    }
    
}

extension BookViewController: BookModalViewControllerDelegate, SearchResultCellDelegate {
    
    func chooseBook(_ book: BookData) {
        RecentBookManager.add(book: book)
        fullCollection.reloadData()
    }
    
    func didTapSearchResult(Book: BookData) {
        RecentBookManager.add(book: Book)
        fullCollection.reloadData()
    }
    
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        data.count
        if section == 0 {
            return recentData.count
            } else {
                return data.count
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                if indexPath.section == 1 {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: SearchResultCell.id,
                        for: indexPath
                    ) as? SearchResultCell else {
                        return UICollectionViewCell()
                    }
                    cell.dataConnect(data: data[indexPath.item])
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(
                        withReuseIdentifier: RecentlyViewedCell.id,
                        for: indexPath) as? RecentlyViewedCell else {
                        return UICollectionViewCell()
                    }
                    cell.setData(data: recentData[indexPath.item])
                    return cell
                }
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: SearchResultCell.id,
//            for: indexPath
//        ) as? SearchResultCell else {
//            return UICollectionViewCell()
//        }
//        cell.dataConnect(data: data[indexPath.item])
       
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SearchResultHeader.id,
                for: indexPath
            ) as! SearchResultHeader
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: RecentlyViewedHeader.id,
                for: indexPath
            ) as! RecentlyViewedHeader
            
            return header
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let chooseBook = data[indexPath.item]
        RecentBookManager.add(book: chooseBook)
        
        fullCollection.reloadData()
        
        let modal = BookModalViewController()
        
        modal.setData(data: data[indexPath.item])
        modal.delegate = self
        modal.selectIndex = indexPath.item
        present(modal, animated: true)
        
        let cart = data[indexPath.item]
        RecentBookManager.add(book: cart)
      
    }
    
}

extension BookViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let explore = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !explore.isEmpty else {
            data = []
            fullCollection.reloadData()
            return
        }
        
        BookApi().fetchData(query: explore) { books in
            DispatchQueue.main.async {
                self.data = books
                self.fullCollection.reloadData()
            }
            
        }
    }
}





