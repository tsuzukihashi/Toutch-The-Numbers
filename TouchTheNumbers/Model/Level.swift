import Foundation

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
      return "すごくむずかしい"
    }
  }

  var maxNum: Int {
    switch self {
    case .easy:
      9
    case .normal:
      16
    case .hard:
      25
    case .extra:
      49
    }
  }

  var row: Int {
    switch self {
    case .easy:
      3
    case .normal:
      4
    case .hard:
      5
    case .extra:
      7
    }
  }

  var widthPercent: CGFloat {
    switch self {
    case .easy:
      0.3
    case .normal:
      0.2
    case .hard:
      0.15
    case .extra:
      0.1
    }
  }
}
