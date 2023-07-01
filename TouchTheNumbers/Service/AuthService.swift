import Foundation
import FirebaseAuth

actor AuthService {
  static let shared: AuthService = .init()
  private let auth: Auth

  private init() {
    self.auth = Auth.auth()
  }

  var isLogin: Bool {
    auth.currentUser != nil
  }

  var uid: String? {
    auth.currentUser?.uid
  }

  func signInAnonymously() async {
    do {
      try await auth.signInAnonymously()
      print("Loggin Success")
    } catch {
      print(error.localizedDescription)
    }
  }
}
