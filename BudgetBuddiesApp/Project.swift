import ProjectDescription

let budgetBuddiesAppSettings: Settings = .settings(
  base: [
    "DEVELOPMENT_LANGUAGE": "ko"
  ],
  configurations: [
    .debug(name: "Debug", xcconfig: "BudgetBuddiesApp/Resources/Debug.xcconfig"),
    .release(name: "Release", xcconfig: "BudgetBuddiesApp/Resources/Release.xcconfig"),
  ])

let budgetBuddiesAppInfoPlist: InfoPlist = .extendingDefault(with: [
  "UILaunchStoryboardName": "LaunchScreen.storyboard",
  "UIApplicationSceneManifest": [
    "UIApplicationSupportsMultipleScenes": false,
    "UISceneConfigurations": [
      "UIWindowSceneSessionRoleApplication": [
        [
          "UISceneConfigurationName": "Default Configuration",
          "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate",
        ]
      ]
    ],
  ],
  // BASE URL을 xcconfig 파일에서 도메인 가져오기
  "BASEURL": "http://$(Base_Domain)",
  // HTTP 프로토콜 네트워크 통신 허용
  "NSAppTransportSecurity": [
    "NSAllowsArbitraryLoads": true
  ],
  // 배포용 앱 한글 이름
  "CFBundleDisplayName": "빈주머니즈",
  // 다크모드 제한
  "UIUserInterfaceStyle": "Light",
  // 앱 카테고리 지정
  "LSApplicationCategoryType": "public.app-category.finance",
  // iPhone Orientation 지정
  "UISupportedInterfaceOrientations": [
    "UIInterfaceOrientationPortrait"
  ],
  // 사용 국가 지정
  "CFBundleDevelopmentRegion": "ko",
])

let project = Project(
  name: "BudgetBuddiesApp",
  options: .options(
    defaultKnownRegions: ["ko"],
    developmentRegion: "ko"
  ),
  settings: budgetBuddiesAppSettings,
  targets: [
    .target(
      name: "BudgetBuddiesApp",
      destinations: [.iPhone],
      product: .app,
      bundleId: "com.budgetbuddiesteam.budgetbuddiesapp",
      deploymentTargets: .iOS("17.0"),
      infoPlist: budgetBuddiesAppInfoPlist,
      sources: ["BudgetBuddiesApp/Sources/**"],
      resources: ["BudgetBuddiesApp/Resources/**"],
      dependencies: [
        .external(name: "Alamofire", condition: .none),
        .external(name: "SnapKit", condition: .none),
        .external(name: "DGCharts", condition: .none),
        .external(name: "Moya", condition: .none),
        .external(name: "Kingfisher", condition: .none),
        .external(name: "PromiseKit", condition: .none),
      ],
      settings: budgetBuddiesAppSettings
    ),
    .target(
      name: "BudgetBuddiesAppTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.budgetbuddiesteam.app.tests",
      infoPlist: budgetBuddiesAppInfoPlist,
      sources: [
        "BudgetBuddiesApp/BudgetBuddiesAppTests/**"
      ],
      dependencies: [
        .target(name: "BudgetBuddiesApp", condition: .none)
      ]
    ),
    .target(
      name: "BudgetBuddiesAppUITests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.budgetbuddiesteam.app.UITests",
      infoPlist: budgetBuddiesAppInfoPlist,
      sources: [
        "BudgetBuddiesApp/BudgetBuddiesAppUITests/**"
      ],
      dependencies: [
        .target(name: "BudgetBuddiesApp", condition: .none)
      ]
    ),
  ]
)
