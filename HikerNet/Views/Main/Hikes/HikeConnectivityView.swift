
import SwiftUI

struct HikeConnectivityView: View {
    @State var hikes: [HikeResponse]
    @State private var connected: Int = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(connected >= 50 ? Constants.Colors.green : Color.red)
                        .frame(width: (geometry.size.width - 60) * CGFloat(connected) / 100 , height: 10)
                    Text("\(connected)%")
                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                        .foregroundColor(connected >= 50 ? Constants.Colors.green : Color.red)
                    Spacer()
                }
                Text("connectivity")
                    .foregroundColor(.secondary)
                    .font(Font.custom(Constants.Fonts.regular, size: 14))
            }
        }
        .onAppear() {
            calcConnectivity()
        }
    }
    
    private func calcConnectivity() {
        var connectedPercentage = 0
        var featureCount = 0
        for hike in hikes {
            for feature in hike.features {
                featureCount += 1
                if feature.serviceState == "IN_SERVICE" {
                    connectedPercentage += 1
                }
            }
        }
        if featureCount > 0 {
            connected = connectedPercentage / featureCount * 100
        } else {
            connected = 0
        }
    }
}
