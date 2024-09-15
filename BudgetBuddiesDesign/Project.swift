import ProjectDescription

let project = Project(
    name: "BudgetBuddiesDesign",
    targets: [
        .target(
            name: "BudgetBuddiesDesign",
            destinations: .iOS,
            product: .framework,
            bundleId: "io.tuist.BudgetBuddiesDesign",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            sources: ["BudgetBuddiesDesign/Sources/**"],
            resources: ["BudgetBuddiesDesign/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "BudgetBuddiesDesignTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.BudgetBuddiesDesignTests",
            infoPlist: .default,
            sources: ["BudgetBuddiesDesign/Tests/**"],
            resources: [],
            dependencies: [.target(name: "BudgetBuddiesDesign")]
        ),
    ]
)
