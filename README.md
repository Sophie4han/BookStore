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

1. MVVM으로 분리는 했으나 아직 ViewModel에 대한 정의가 부족했던 탓에 실직적으로는 MVC패턴을 기반으로 나눴다
2. 모달이나 셀 간 데이터 전달을 위해 Delegate Pattern을 사용했는데, 프로토콜 정의와 흐름 설계에 시간이 꽤 걸렸다
   특히 delegate 순환 참조나 weak 키워드 누락 등 기본 개념을 실전에서 직접 겪으며 익혔다
3. 프로젝트 초반 전체 구조 파악이 부족해서 같은 기능의 화면을 중복 생성하는 실수를 저질렀고
   이로 인해 일부 전환 시 빈 화면이 뜨는 문제도 발생했다. 구조 이해의 중요성을 체감했다
4. 직접 네트워크 요청을 구성하고 JSON을 파싱하며 URLSession 사용이 훨씬 익숙해졌다
   응답 상태 체크, Codable 디코딩 등 네트워크 흐름을 스스로 구성해볼 수 있었다
5. UICollectionView의 CompositionalLayout을 사용하며 리스트 UI 구성이 훨씬 유연하다는 것을 느꼈다. 
   활용이 유연한 만큼 적응을 위해 학습이 더 필요할 것 같다
