# CurrencyCalculator0414
- 환율 계산기 앱

# 기능
- 환율 리스트
- 환율 하락,상승,유지 여부 표시
- 특정 국가 환율 즐겨찾기
- 환율 계산기 
- 환율 검색
- 다크모드
- 코어 데이터를 이용해 즐겨찾기 저장, 마지막 페이지 저장 

# 프로젝트 구조
```
├── CurrencyCalculator0414
│   ├── Base.lproj
│   ├── Data
│   │   ├── Network
│   │   │   ├── DataMapping
│   │   │   │   └── CurrencyMapper.swift
│   │   │   └── DataService.swift
│   │   ├── PersistantStorages
│   │   │   ├── CachedCurrencyRate+CoreDataClass.swift
│   │   │   ├── CachedCurrencyRate+CoreDataProperties.swift
│   │   │   ├── CoreDataManager.swift
│   │   │   ├── FavoriteCurrency+CoreDataClass.swift
│   │   │   ├── FavoriteCurrency+CoreDataProperties.swift
│   │   │   ├── LastViewedScreen+CoreDataClass.swift
│   │   │   └── LastViewedScreen+CoreDataProperties.swift
│   │   └── Repositories
│   │       ├── CachedCurrencyRateRepository.swift
│   │       ├── CurrencyRepository.swift
│   │       ├── FavoriteCurrencyRepository.swift
│   │       └── LastViewedScreenRepository.swift
│   ├── Domain
│   │   ├── Entities
│   │   │   └── Currency.swift
│   │   ├── Interfaces
│   │   │   ├── Network
│   │   │   │   └── DataServiceProtocol.swift
│   │   │   └── Repositories
│   │   │       ├── CachedCurrencyRateRepositoryProtocol.swift
│   │   │       ├── CurrencyRepositoryProtocol.swift
│   │   │       ├── FavoriteCurrencyRepositoryProtocol.swift
│   │   │       └── LastViewedScreenRepositoryProtocol.swift
│   │   └── UseCases
│   │       ├── CachedCurrencyRateUseCase.swift
│   │       ├── CurrencyUseCase.swift
│   │       ├── FavoriteCurrencyUseCase.swift
│   │       └── LastViewedScreenUseCase.swift
│   ├── Info.plist
│   ├── Presentation
│   │   ├── View
│   │   │   ├── CurrencyListView.swift
│   │   │   ├── CurrencyListViewCell.swift
│   │   │   ├── CurrencyViewController.swift
│   │   │   └── MainViewController.swift
│   │   └── ViewModel
│   │       ├── CurrencyViewModel.swift
│   │       └── MainViewModel.swift
│   └── Support
│       ├── AppDelegate.swift
│       ├── Assets.xcassets
│       │   ├── AccentColor.colorset
│       │   │   └── Contents.json
│       │   ├── AppIcon.appiconset
│       │   │   └── Contents.json
│       │   └── Contents.json
│       ├── Base.lproj
│       │   └── LaunchScreen.storyboard
│       ├── CurrencyCalculator0414.xcdatamodeld
│       │   └── CurrencyCalculator0414.xcdatamodel
│       │       └── contents
│       └── SceneDelegate.swift
├── CurrencyCalculator0414.xcodeproj
│   ├── project.pbxproj
│   ├── project.xcworkspace
│   │   ├── contents.xcworkspacedata
│   │   ├── xcshareddata
│   │   │   └── swiftpm
│   │   │       └── configuration
│   │   └── xcuserdata
│   │       └── tlswo.xcuserdatad
│   │           └── UserInterfaceState.xcuserstate
│   ├── xcshareddata
│   │   └── xcschemes
│   │       └── CurrencyCalculator0414.xcscheme
│   └── xcuserdata
│       └── tlswo.xcuserdatad
│           └── xcschemes
│               └── xcschememanagement.plist
├── CurrencyCalculator0414Tests
│   └── CurrencyCalculator0414Tests.swift
├── CurrencyCalculator0414UITests
│   ├── CurrencyCalculator0414UITests.swift
│   └── CurrencyCalculator0414UITestsLaunchTests.swift
└── README.md
```

# 시연 영상 
https://github.com/user-attachments/assets/9e1c669e-6656-4da8-86db-551b4082710b

# 메모리 누수가 없음을 증빙하는 자료 
<img width="1269" alt="스크린샷 2025-04-16 14 27 33" src="https://github.com/user-attachments/assets/20e273ab-f03c-48a0-b2fd-43157ccb919c" />
Instruments의 Leaks 및 Allocations 도구를 활용한 분석 결과, 누수가 발견되지 않았으며 앱은 안정적으로 실행되었습니다.아래 캡처는 테스트 당시의 메모리 분석 결과를 나타내며, Leak Checks 항목의 체크 표시를 통해 메모리 누수 없음이 확인됩니다.
