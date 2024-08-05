import ProjectDescription

let settings: Settings = .settings(configurations: [
  .debug(name: "Debug", xcconfig: "BudgetBuddies/Resources/Debug.xcconfig"),
  .release(name: "Release", xcconfig: "BudgetBuddies/Resources/Release.xcconfig"),
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
      infoPlist: .extendingDefault(with: [
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
        "BASEURL": "http://$(Base_Domain)"
      ]),
      sources: ["BudgetBuddies/Sources/**"],
      resources: ["BudgetBuddies/Resources/**"],
      dependencies: [
        .external(name: "Alamofire"),
        .external(name: "SnapKit"),
        .external(name: "DGCharts"),
        .external(name: "Moya"),
        .external(name: "RxSwift")
      ],
      settings: settings
    )
  ]
)
