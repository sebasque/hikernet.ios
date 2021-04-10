
import SwiftUI

// MARK: Card view for showing hike information
struct HikeCardView: View {
    @State var hike: HikeResponse
    @State private var offsets = (top: CGFloat.zero, bottom: CGFloat.zero)
    @State private var lastOffset: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 20) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(UIColor.systemGray6))
                    .frame(width: 35, height: 8)
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(FormatManager.getLocalDateString(time: hike.start))
                            .foregroundColor(.secondary)
                            .font(Font.custom(Constants.Fonts.regular, size: 17))
                        Text(FormatManager.getDayDescription(date: FormatManager.getLocalDate(time: hike.start)))
                            .foregroundColor(.primary)
                            .font(Font.custom(Constants.Fonts.medium, size: 24))
                        
                        HikeConnectivityView(hikes: [hike])
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 32, trailing: 0))
                        
                        HStack {
                            HStack(alignment: .center, spacing: 32) {
                                VStack(alignment: .leading) {
                                    Text("\(hike.carrier)")
                                        .foregroundColor(.primary)
                                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                                    Text("carrier")
                                        .foregroundColor(.secondary)
                                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                                }
                                VStack(alignment: .leading) {
                                    Text(FormatManager.getDistance(distance: hike.distance))
                                        .foregroundColor(.primary)
                                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                                    Text("distance")
                                        .foregroundColor(.secondary)
                                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                                }
                                VStack(alignment: .leading) {
                                    Text(FormatManager.getStopWatchTime(elapsedSeconds: hike.duration))
                                        .foregroundColor(.primary)
                                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                                    Text("time")
                                        .foregroundColor(.secondary)
                                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                                }
                            }
                            Spacer()
                        }
                        .padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.85))
            .offset(y: self.offset)
            .gesture(DragGesture()
                .onChanged { v in
                    updateCardOffset(value: v)
                }
                .onEnded { v in
                    updateCardOffset(value: v)
                }
             )
            .onAppear {
                self.offsets = (
                    top: geometry.size.height * 3 / 6,
                    bottom: geometry.size.height * 3 / 3.9
                )
                self.offset = self.offsets.bottom
                self.lastOffset = self.offset
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear() {
            UIScrollView.appearance().bounces = true
        }
    }
    
    private func updateCardOffset(value: DragGesture.Value) {
        withAnimation {
            if (value.translation.height > 0) {
                self.offset = self.offsets.bottom
            } else {
                self.offset = self.offsets.top
            }
            self.lastOffset = self.offset
        }
    }
}
