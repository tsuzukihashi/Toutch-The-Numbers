import SwiftUI

struct RankingView: View {
  @StateObject var viewModel: RankingViewModel = .init()
  @Environment(\.dismiss) var dismiss

  var body: some View {
    ScrollView {
      VStack {
        Text("みんなのランキング")
          .font(.title)
          .fontWeight(.bold)

        Picker("Level", selection: $viewModel.selectedLevel) {
          ForEach(Level.allCases) { level in
            Text(level.title)
              .font(.caption)
              .tag(level)
          }
        }
        .pickerStyle(.segmented)
        .onChange(of: viewModel.selectedLevel, perform: { value in
          Task {
            await viewModel.fetchScore()
          }
        })

        if viewModel.scores.isEmpty {
          VStack {
            Image(systemName: "note.text")
              .resizable()
              .scaledToFit()
              .frame(width: 120, height: 120)

            Text("No Data")
              .foregroundColor(.secondary)
          }
          .padding(.top, 64)
        } else {
          ForEach(viewModel.scores) { score in
            HStack {
              Image(score.iconType.rawValue)
                .resizable()
                .scaledToFit()
                .frame(width: 44, height: 44)
                .clipShape(Circle())
              VStack(alignment: .leading) {
                Text("\(score.time)")
                  .font(.title)
                  .bold()
                Text("@" + score.uid.prefix(6))
                  .font(.caption)
                  .foregroundColor(.secondary)
              }

              Spacer()

              VStack {
                HStack(spacing: 4) {
                  Text(String((viewModel.scores.firstIndex(where: { $0.id == score.id }) ?? 0) + 1))
                    .font(.caprasimo(size: 24))
                    .bold()
                  Text("位")
                    .font(.headline)
                    .offset(y: 2)
                }
              }
              .background(alignment: .bottom) {
                Rectangle()
                  .frame(height: 1)
                  .scaleEffect(x: 1.2)
              }
            }
          }
        }
      }
      .padding(32)
      .task {
        await viewModel.fetchScore()
      }
    }
    .overlay(alignment: .topLeading) {
      Button {
        dismiss()
      } label: {
        Image(systemName: "xmark.circle.fill")
          .font(.title)
      }
      .padding(32)
    }
  }
}

@available(iOS 17.0, *)
#Preview {
  RankingView()
}
