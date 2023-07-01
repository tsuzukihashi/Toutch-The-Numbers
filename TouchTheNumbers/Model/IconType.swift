import Foundation

enum IconType: String, Codable, CaseIterable {
  case man
  case woman
  case dog
  case cat

  static func random() -> IconType {
    let all = IconType.allCases
    return all.randomElement() ?? .man
  }
}
