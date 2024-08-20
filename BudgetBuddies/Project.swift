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
  "BASEURL": "http://$(Base_Domain)",
  "NSAppTransportSecurity": [
    "NSAllowsArbitraryLoads": true
  ],
])

let project = Project(
  name: "BudgetBuddies",
  settings: settings,
  targets: [
    .target(
      name: "BudgetBuddies",
      destinations: .iOS,
      product: .app,
      bundleId: "com.budgetBuddies.app",
      infoPlist: budgetBuddiesInfoPlist,
      sources: ["BudgetBuddies/Sources/**"],
      resources: ["BudgetBuddies/Resources/**"],
      dependencies: [
        .external(name: "Alamofire", condition: .none),
        .external(name: "SnapKit", condition: .none),
        .external(name: "DGCharts", condition: .none),
        .external(name: "Moya", condition: .none),
        .external(name: "Kingfisher", condition: .none),
        .external(name: "RxSwift", condition: .none),
        .external(name: "RxCocoa", condition: .none),
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
