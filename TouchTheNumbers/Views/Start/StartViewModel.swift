import Foundation

class StartViewModel: ObservableObject {
  @Published var scores: [Score] = []

  private let authService: AuthService = .shared
  private let scoreService: ScoreService = .shared

  func onAppear() async {
    if await authService.isLogin {
      do {
        let value = try await scoreService.fetchMyScores()
        await updateScore(value)
      } catch {
        print(error.localizedDescription)
      }
    } else {
      await authService.signInAnonymously()
    }
  }

  @MainActor
  func updateScore(_ scores: [Score]) {
    self.scores = scores
  }
}
