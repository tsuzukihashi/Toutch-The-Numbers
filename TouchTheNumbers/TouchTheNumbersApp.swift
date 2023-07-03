import SwiftUI
import FirebaseCore
import AppTrackingTransparency

@main
struct TouchTheNumbersApp: App {
  init() {
    FirebaseApp.configure()
  }
  
  var body: some Scene {
    WindowGroup {
      StartView()
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
          ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in

          })
        }
    }
  }
}
