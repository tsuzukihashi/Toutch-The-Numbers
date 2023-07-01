import Foundation
import SwiftUI

enum Level: String, CaseIterable, Identifiable, Codable {
  case easy
  case normal
  case hard
  case extra

  var id: String {
    UUID().uuidString
  }

  var title: String {
    switch self {
    case .easy:
      return "かんたん"
    case .normal:
      return "ふつう"
    case .hard:
      return "むずかしい"
    case .extra:
      return "おに"
    }
  }

  var maxNum: Int {
    switch self {
    case .easy:
      return 9
    case .normal:
      return 16
    case .hard:
      return 25
    case .extra:
      return 49
    }
  }

  var row: Int {
    switch self {
    case .easy:
      return 3
    case .normal:
      return 4
    case .hard:
      return 5
    case .extra:
      return 7
    }
  }

  var widthPercent: CGFloat {
    switch self {
    case .easy:
      return 0.3
    case .normal:
      return 0.2
    case .hard:
      return 0.15
    case .extra:
      return 0.1
    }
  }

  var color: Color {
    switch self {
    case .easy:
      return .green
    case .normal:
      return .blue
    case .hard:
      return .purple
    case .extra:
      return .red
    }
  }
}
