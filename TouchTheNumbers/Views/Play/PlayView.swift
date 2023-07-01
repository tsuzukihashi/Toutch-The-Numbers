import SwiftUI

struct PlayView: View {
  @StateObject var viewModel: PlayViewModel
  @Environment(\.dismiss) var dismiss

  init(viewModel: PlayViewModel) {
    self._viewModel = StateObject(wrappedValue: viewModel)
  }

  func header() -> some View {
    HStack {
      Text("Time: ")

      if let endTimeStr = viewModel.convertDate() {
        Text(endTimeStr)
      } else if let startTime = viewModel.startTime {
        Text(startTime, style: .timer)
      }
    }
    .font(.title)
    .fontWeight(.bold)
  }

  @ViewBuilder
  func main(proxy: GeometryProxy) -> some View {
    let size = proxy.size.width * viewModel.getWidthPercent()

    LazyVGrid(
      columns: viewModel.createColumns(size: size),
      content: {
        ForEach(viewModel.numbers, id: \.display) { num in
          ZStack {
            RoundedRectangle(cornerRadius: 8)
              .foregroundColor((viewModel.getTargetNumber(num: num)?.isSelected == true) ? .secondary : .red)
            Text("\(num.display)")
              .font(.title)
              .bold()
              .foregroundColor(.white)
          }
          .frame(height: size)
          .onTapGesture {
            viewModel.tapNumber(num: num)
          }
        }
      })
  }

  var body: some View {
    GeometryReader { proxy in
      VStack {
        header()
        main(proxy: proxy)
      }
      .onAppear {
        viewModel.onAppear()
      }
      .animation(.easeInOut, value: viewModel.numbers)
      .safeAreaInset(edge: .bottom) {


        Button {
          if viewModel.finished {
            Task {
              await viewModel.uploadScoreButton()
            }
          }
          dismiss()
        } label: {
          Text(viewModel.finished ? "DONE" : "CLOSE")
        }
        .buttonStyle(.borderedProminent)
      }
    }
  }
}

@available(iOS 17.0, *)
#Preview {
  PlayView(viewModel: .init(selectedLevel: .easy, oldScore: nil))
}
