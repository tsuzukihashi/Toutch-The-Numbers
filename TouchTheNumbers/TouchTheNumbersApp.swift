import SwiftUI
import FirebaseCore

@main
struct TouchTheNumbersApp: App {
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      StartView()
    }
  }
}
