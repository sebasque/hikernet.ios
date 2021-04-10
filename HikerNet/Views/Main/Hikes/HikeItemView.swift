
import SwiftUI

// MARK: Individual hike item in the recent activity list
struct HikeItemView: View {
    @State var hike: HikeResponse
    @State private var connectivity = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(FormatManager.getLocalDateString(time: hike.start))
                        .foregroundColor(.secondary)
                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                    Text(FormatManager.getDayDescription(date: FormatManager.getLocalDate(time: hike.start)))
                        .foregroundColor(.primary)
                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                }
                .padding(EdgeInsets(top: 18, leading: 24, bottom: 0, trailing: 24))
                Spacer()
            }
            HStack {
                HStack(alignment: .center, spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("\(connectivity)%")
                            .foregroundColor(connectivity >= 50 ? Constants.Colors.green : Color.red)
                            .font(Font.custom(Constants.Fonts.medium, size: 17))
                        Text("connectivity")
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
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
        )
        .onAppear() {
            connectivity = ConnectivityManager.calcConnectivity(hike: hike)
        }
    }
}
