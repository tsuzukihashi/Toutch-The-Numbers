import SwiftUI

struct StartView: View {
  @State var showPlayView: Bool = false
  @State var showRankingView: Bool = false
  @State var selectedLevel: Level?

  @StateObject var viewModel: StartViewModel = .init()

  var body: some View {
    VStack(spacing: 64) {
      Text("Toutch\nThe Numbers")
        .font(.caprasimo(size: 48))
        .multilineTextAlignment(.center)
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
            .tint(level.color)

            HStack {
              Text("High Score: ")
              if let score = viewModel.scores.first(where: { $0.level == level }) {
                Text(String(format: "%.4f", score.time))
              } else {
                Text("???")
              }
            }
          }
          .padding(.horizontal, 32)
        }
      }
    }
    .safeAreaInset(edge: .bottom, content: {
      Button(action: {
        showRankingView = true
      }, label: {
        Text("Ranking")
          .font(.title)
          .fontWeight(.bold)
      })
      .buttonStyle(.borderedProminent)
    })
    .fullScreenCover(item: $selectedLevel, onDismiss: {
      Task {
        await viewModel.onAppear()
      }
    }, content: { level in
      PlayView(viewModel: .init(selectedLevel: level, oldScore: viewModel.scores.first(where: { $0.level == level })))
    })
    .sheet(isPresented: $showRankingView, content: {
      RankingView()
    })
    .task {
      await viewModel.onAppear()
    }
  }
}

@available(iOS 17.0, *)
#Preview {
  StartView()
}
