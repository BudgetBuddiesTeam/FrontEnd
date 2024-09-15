// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [:]
    )
#endif

let package = Package(
    name: "BudgetBuddies",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
      .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
      .package(url: "https://github.com/SnapKit/SnapKit", from: "5.7.1"),
      .package(url: "https://github.com/danielgindi/Charts.git", from: "5.1.0"),
      .package(url: "https://github.com/Moya/Moya", from: "15.0.3"),
      .package(url: "https://github.com/onevcat/Kingfisher", from: "7.12.0"),
      .package(url: "https://github.com/ReactiveX/RxSwift", from: "6.7.1"),
      .package(url: "https://github.com/mxcl/PromiseKit", from: "8.1.2"),
    ]
)
