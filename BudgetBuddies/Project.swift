import ProjectDescription

let settings: Settings = .settings(configurations: [
  .debug(name: "Debug", xcconfig: "BudgetBuddies/Resources/Debug.xcconfig"),
  .release(name: "Release", xcconfig: "BudgetBuddies/Resources/Release.xcconfig"),
])

let budgetBuddiesInfoPlist: InfoPlist = .extendingDefault(with: [
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
  "CFBundleVersion": "1.1.0",
  "CFBundleShortVersionString": "1.1.0"
])

let project = Project(
  name: "BudgetBuddies",
  targets: [
    .target(
      name: "BudgetBuddies",
      destinations: [.iPhone],
      product: .app,
      bundleId: "com.budgetbuddiesteam.budgetbuddiesapp",
      deploymentTargets: .iOS("17.0"),
      infoPlist: budgetBuddiesInfoPlist,
      sources: ["BudgetBuddies/Sources/**"],
      resources: ["BudgetBuddies/Resources/**"],
      dependencies: [
        .external(name: "Alamofire", condition: .none),
        .external(name: "SnapKit", condition: .none),
        .external(name: "DGCharts", condition: .none),
        .external(name: "Moya", condition: .none),
        .external(name: "Kingfisher", condition: .none),
        .external(name: "PromiseKit", condition: .none),
      ],
      settings: settings
    ),
    .target(
      name: "BudgetBuddiesTests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.budgetBuddies.app.tests",
      infoPlist: budgetBuddiesInfoPlist,
      sources: [
        "BudgetBuddies/BudgetBuddiesTests/**"
      ],
      dependencies: [
        .target(name: "BudgetBuddies", condition: .none)
      ]
    ),
    .target(
      name: "BudgetBuddiesUITests",
      destinations: .iOS,
      product: .unitTests,
      bundleId: "com.budgetBuddies.app.UITests",
      infoPlist: budgetBuddiesInfoPlist,
      sources: [
        "BudgetBuddies/BudgetBuddiesUITests/**"
      ],
      dependencies: [
        .target(name: "BudgetBuddies", condition: .none)
      ]
    ),
  ]
)
