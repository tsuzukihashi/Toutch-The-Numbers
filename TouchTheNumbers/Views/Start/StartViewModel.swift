import Foundation

class StartViewModel: ObservableObject {
  @Published var scores: [Score] = []
  @Published var userID: String?

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

    await updateUID(await authService.uid)
  }

  @MainActor
  func updateScore(_ scores: [Score]) {
    self.scores = scores
  }

  @MainActor
  func updateUID(_ value: String?) {
    self.userID = value
  }
}
