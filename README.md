# BookStore

## 소개

BookStore는 iOS 부트캠프 심화주차 개인 프로젝트로 
기본 + 숙련 주차  개인 및 팀 프로젝트에서 사용된 기능이나 UI를 복함적으로 사용한 프로젝트였습니다.


- 모달 및 화면 간 이동
- CollectionView CompositionalLayout
- UserDefaults를 활용한 데이터 저장
- Delegate 패턴, TabBar, SearchBar, URLSession 구현

---

## 기술 스택 및 사용 기술

| 분야 | 내용 |
|------|------|
| UI 구성 | UIKit, SnapKit (스토리보드 미사용)                                                    |
| 도서 API | Kakao 책 검색 API (BookApi struct, URLSession 사용)                                      |
| 검색 기능 | 커스텀 SearchBar                         |
| 데이터 저장 | UserDefaults + Codable 사용 (최근 본 책, 장바구니 등 저장)                                    |
| 화면 구조 | MVVM으로 분리는 했으나 MVC패턴 기반                               |
| 이벤트 전달 | Delegate Pattern 사용                                                           |
| 기타 |모달 전환, 커스텀 UICollectionView Header/Cell, CompositionalLayout 구성                                   |
|-----------------------|-------------------------------------------------------------------------------------------------------------|

---

```
BookStore/
├── Model
│   ├── BookStoreCareManager.swift
│   └── BookStoreData.swift
│   └── DataManeger.swift
│   └── RecentBookManager.swift
├── View
│   ├── AddButton.swift
│   ├── ├── AddCell.swift
│   ├── ├── AddViewController.swift
│   ├── MainView.swift
│   ├── ├── BookViewController.swift
│   ├── ├── RecentlyViewedCell.swift
│   ├── ├── SearchResultCell.swift
│   ├── Modal.swift
│   ├── ├── ModalViewController.swift
│   ├── UIBar.swift
│   ├── ├── SearchBar.swift
│   ├── ├── TabBar.swift
├── ViewModel/
│   ├── AppDelegate.swift
│   ├── LaunchScreen.swift
│   ├── RecentlyViewedHeader.swift
│   ├── SceneDelegate.swift
│   └── SearchResultHeader.swift
''
```

## 프로젝트 회고 (onBoard - 킥보드 앱)
- 앱 개발 기초 부터 숙련 전반을 아울러 다 복습해볼 수 있던 프로젝트
- 모듈화와 코드 분리를 시도했지만 MVVM 구조화에는 미숙했던 점 인식
- 데이터 흐름과 뷰 간 역할 분리를 좀 더 명확하게 할 필요성을 느낌
