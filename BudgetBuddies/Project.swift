import ProjectDescription

let project = Project(
  name: "BudgetBuddies",
  targets: [
    .target(
      name: "BudgetBuddies",
      destinations: .iOS,
      product: .app,
      bundleId: "com.budgetBuddies.app",
      sources: ["BudgetBuddies/Sources/**"],
      resources: ["BudgetBuddies/Resources/**"],
      dependencies: [
        .external(name: "Alamofire"),
        .external(name: "SnapKit"),
      ]
    )
  ]
)
