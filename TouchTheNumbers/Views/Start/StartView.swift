import SwiftUI

struct StartView: View {
  @State var showPlayView: Bool = false
  @State var showRankingView: Bool = false
  @State var selectedLevel: Level?

  @StateObject var viewModel: StartViewModel = .init()

  var body: some View {
    VStack(spacing: 32) {
      VStack {
        Text("Toutch\nThe Numbers")
          .font(.caprasimo(size: 48))
          .multilineTextAlignment(.center)
          .bold()

        HStack {
          Text("ID:")
          if let uid = viewModel.userID {
            Text(uid.prefix(6))
          }
        }
        .font(.caption)
        .foregroundColor(.secondary)
      }

      VStack(spacing: 16) {
        ForEach(Level.allCases) { level in
          VStack(alignment: .center, spacing: 4) {
            Button(action: {
              selectedLevel = level
              showPlayView = true
            }, label: {
              Text(level.title)
                .frame(maxWidth: .infinity)
                .bold()
                .font(.headline)
                .padding(8)
            })
            .buttonStyle(.borderedProminent)
            .tint(level.color)

            HStack {
              Text("HighScore:")
              if let score = viewModel.scores.first(where: { $0.level == level }) {
                Text(String(format: "%.4f", score.time))
              } else {
                Text("???")
              }
            }
            .foregroundColor(.secondary)
          }
          .padding(.horizontal, 32)
        }
      }
    }
    .padding(.vertical, 32)
    .safeAreaInset(edge: .bottom, content: {
      Button(action: {
        showRankingView = true
      }, label: {
        Label("Ranking", systemImage: "medal")
          .font(.title)
          .fontWeight(.bold)
      })
      .buttonStyle(.borderedProminent)
      .tint(.black)
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
