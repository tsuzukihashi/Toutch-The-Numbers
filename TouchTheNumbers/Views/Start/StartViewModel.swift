import Foundation

class StartViewModel: ObservableObject {
  let authService: AuthService = .shared

  func onAppear() async {
    if await authService.isLogin {
      
    } else {
      await authService.signInAnonymously()

    }
  }
}
