
import SwiftUI

struct HikeCardView: View {
    @State var hike: HikeResponse
    @State private var offsets = (top: CGFloat.zero, bottom: CGFloat.zero)
    @State private var lastOffset: CGFloat = .zero
    @State private var offset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            VStack (spacing: 20) {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(Color(UIColor.systemGray5))
                    .frame(width: 35, height: 8)
                    .onTapGesture {
                        if (self.offset == self.offsets.top) {
                            self.offset = self.offsets.bottom
                        } else {
                            self.offset = self.offsets.top
                        }
                        self.lastOffset = self.offset
                    }
                    .gesture(DragGesture()
                        .onChanged { v in
                            self.offset = self.lastOffset + v.translation.height
                        }
                        .onEnded{ v in
                            if (v.translation.height > 0) {
                                self.offset = self.offsets.bottom
                            } else {
                                self.offset = self.offsets.top
                            }
                            self.lastOffset = self.offset
                        }
                    )
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(TimeFormatter.getLocalDateString(time: hike.start))
                            .foregroundColor(.secondary)
                            .font(Font.custom(Constants.Fonts.regular, size: 17))
                        Text(TimeFormatter.getDayDescription(date: TimeFormatter.getLocalDate(time: hike.start)))
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
                                    Text(String(format: "%.2f", arguments: [hike.distance]) + " km")
                                        .foregroundColor(.primary)
                                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                                    Text("distance")
                                        .foregroundColor(.secondary)
                                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                                }
                                VStack(alignment: .leading) {
                                    Text(TimeFormatter.getStopWatchTime(elapsedSeconds: hike.duration))
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
                .gesture(DragGesture()
                    .onChanged { v in
                        withAnimation {
                            if (v.translation.height > 0) {
                                self.offset = self.offsets.bottom
                            } else {
                                self.offset = self.offsets.top
                            }
                            self.lastOffset = self.offset
                        }
                    }
                 )
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color(UIColor.systemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.8, blendDuration: 0.85))
            .onAppear {
                self.offsets = (
                    top: geometry.size.height * 3 / 6,
                    bottom: geometry.size.height * 3 / 3.95
                )
                self.offset = self.offsets.bottom
                self.lastOffset = self.offset
            }
            .offset(y: self.offset)
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear() {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear() {
            UIScrollView.appearance().bounces = true
        }
    }
    
}
