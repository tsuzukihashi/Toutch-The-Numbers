import Foundation

class RankingViewModel: ObservableObject {
  @Published var selectedLevel: Level = .easy
  @Published var scores: [Score] = []

  private let scoreService: ScoreService = .shared

  func fetchScore() async {
    do {
      let value = try await scoreService.fetchScores(level: selectedLevel)
      await updateScores(value)
    } catch {
      print(error.localizedDescription)
    }
  }

  @MainActor
  func updateScores(_ scores: [Score]) {
    self.scores = scores
  }
}
