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
          VStack(alignment: .leading) {
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

            HStack {
              Text("High Score: ")
              if let score = viewModel.scores.first(where: { $0.level == level }) {
                Text(String(format: "%.4f", score.time))
              }
            }
          }
          .padding(.horizontal, 32)
        }
      }
    }
    .fullScreenCover(item: $selectedLevel, onDismiss: {
      Task {
        await viewModel.onAppear()
      }
    }, content: { level in
      PlayView(viewModel: .init(selectedLevel: level, oldScore: viewModel.scores.first(where: { $0.level == level })))
    })
    .task {
      await viewModel.onAppear()
    }
  }
}

#Preview {
  StartView()
}
