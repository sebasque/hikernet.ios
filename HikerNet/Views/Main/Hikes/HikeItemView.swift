
import SwiftUI

struct HikeItemView: View {
    @State var hike: HikeResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(TimeFormatter.getLocalDateString(time: hike.startTime))
                        .foregroundColor(.secondary)
                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                    Text(TimeFormatter.getDayDescription(date: TimeFormatter.getLocalDate(time: hike.startTime)))
                        .foregroundColor(.primary)
                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                }
                .padding(EdgeInsets(top: 18, leading: 24, bottom: 0, trailing: 24))
                Spacer()
            }
            HStack {
                HStack(alignment: .center, spacing: 32) {
                    VStack(alignment: .leading) {
                        Text("\(calcConnectivity())%")
                            .foregroundColor(calcConnectivity() >= 50 ? Constants.Colors.green : Color.red)
                            .font(Font.custom(Constants.Fonts.medium, size: 17))
                        Text("connectivity")
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
                .padding(EdgeInsets(top: 0, leading: 24, bottom: 18, trailing: 24))
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color(UIColor.secondarySystemBackground))
        )
    }
    
    private func calcConnectivity() -> Int {
        var total = 0
        for feature in hike.features {
            if feature.serviceState == "IN_SERVICE" {
                total += 1
            }
        }
        return total / hike.features.count * 100
    }
}
