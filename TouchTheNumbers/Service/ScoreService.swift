import FirebaseFirestore
import FirebaseFirestoreSwift

actor ScoreService {
  static let shared: ScoreService = .init()
  private let authService: AuthService = .shared
  private let firestore: Firestore

  private init() {
    self.firestore = Firestore.firestore()
  }

  func fetchMyScores() async throws -> [Score] {
    guard let uid = await authService.uid else { return [] }
    do {
      return try await firestore.collection("scores")
        .whereField("uid", isEqualTo: uid)
        .getDocuments()
        .documents
        .compactMap { try $0.data(as: Score.self) }
    } catch {
      throw error
    }
  }

  func uploadScore(_ score: Score) async throws {
    guard let uid = await authService.uid else { return }
    do {
      try await firestore.collection("scores")
        .document(score.id)
        .setData([
          "id" : score.id,
          "uid": uid,
          "iconType": score.iconType.rawValue,
          "level": score.level.rawValue,
          "time": score.time,
          "createdAt": FieldValue.serverTimestamp(),
          "updatedAt": FieldValue.serverTimestamp(),
        ])
    } catch {
      throw error
    }
  }

  func updateScore(_ score: Score) async throws {
    do {
      try await firestore.collection("scores")
        .document(score.id)
        .updateData([
          "time": score.time,
          "updatedAt" : FieldValue.serverTimestamp()
        ])
    } catch {
      throw error
    }
  }
}
