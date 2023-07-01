import Foundation

/**
 scores/{score_id}
 */
struct Score: Codable {
  var id: String
  var uid: String
  var iconType: IconType
  var level: Level
  var time: Double
  var createdAt: Date
  var updatedAt: Date

  init(iconType: IconType, level: Level, time: Double) {
    self.id = UUID().uuidString
    self.uid = ""
    self.iconType = iconType
    self.level = level
    self.time = time
    self.createdAt = .init()
    self.updatedAt = .init()
  }
}
