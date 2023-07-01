import SwiftUI

struct StartView: View {
  @State var showPlayView: Bool = false
  @State var selectedLevel: Level?

  @StateObject var viewModel: StartViewModel = .init()

  var body: some View {
    VStack(spacing: 32) {
      Text("Toutch The Numbers")
        .font(.title)
        .bold()

      VStack {
        ForEach(Level.allCases) { level in
          Button(action: {
            selectedLevel = level
            showPlayView = true
          }, label: {
            Text(level.title)
              .frame(maxWidth: .infinity)
              .bold()
              .font(.headline)
          })
          .buttonStyle(.borderedProminent)
          .padding(.horizontal, 32)
        }
      }
    }
    .fullScreenCover(item: $selectedLevel, content: { level in
      PlayView(viewModel: .init(selectedLevel: level))
    })
    .task {
      await viewModel.onAppear()
    }
  }
}

#Preview {
  StartView()
}
