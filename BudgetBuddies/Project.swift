import ProjectDescription

let project = Project(
    name: "BudgetBuddies",
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
                                "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                            ]
                        ]
                    ]
                ]
              ]),
            sources: ["BudgetBuddies/Sources/**"],
            resources: ["BudgetBuddies/Resources/**"],
            dependencies: []
        )
    ]
)
