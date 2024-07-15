// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
import Foundation// MARK: - Swift Bundle Accessor for Frameworks
private class BundleFinder {}
extension Foundation.Bundle {
/// Since Alamofire is a framework, the bundle for classes within this module can be used directly.
static let module = Bundle(for: BundleFinder.self)
}// swiftlint:enable all
// swiftformat:enable all