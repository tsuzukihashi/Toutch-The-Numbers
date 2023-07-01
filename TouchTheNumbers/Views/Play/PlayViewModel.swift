import SwiftUI

class PlayViewModel: ObservableObject {
  @Published var numbers: [NumberModel] = []
  @Published var lastTappedNumber: NumberModel = .init(display: 0)
  @Published var startTime: Date?
  @Published var endTime: Date?
  @Published var finished: Bool = false

  var selectedLevel: Level

  init(selectedLevel: Level) {
    self.selectedLevel = selectedLevel
  }

  func onAppear() {
    startTime = .now
    numbers = (1...selectedLevel.maxNum).map { NumberModel(display: $0) }.shuffled()
  }

  func createColumns(size: CGFloat) -> [GridItem] {
    let columns: [GridItem] = Array(repeating: .init(.fixed(size)), count: selectedLevel.row)

    return columns
  }

  func getTargetNumber(num: NumberModel) -> NumberModel? {
    guard let targetIndex = numbers.firstIndex(where: { $0.display == num.display }) else { return nil }
    return numbers[targetIndex]
  }

  func getWidthPercent() -> CGFloat {
    selectedLevel.widthPercent
  }

  func tapNumber(num: NumberModel) {
    guard let targetIndex = numbers.firstIndex(where: { $0.display == num.display }) else { return }

    if lastTappedNumber.display == num.display - 1 {
      numbers[targetIndex].isSelected = true
      self.lastTappedNumber = num
      check(num: num)
    }
  }

  func check(num: NumberModel) {
    if selectedLevel.maxNum == num.display {
      // TOOD: Finished
      endTime = .now
      finished = true
    }
  }

  func convertDate() -> String? {
    guard let startTime, let endTime else { return nil }
    let time = endTime.timeIntervalSince(startTime)
    
    let dateFormatter = DateComponentsFormatter()

    dateFormatter.unitsStyle = .positional
    dateFormatter.allowedUnits = [.hour, .minute, .second, .nanosecond]

    return dateFormatter.string(from: time)
  }
}
