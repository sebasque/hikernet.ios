
import SwiftUI

struct HikeConnectivityView: View {
    @State var hikes: [HikeResponse]
    @State private var connected: Int = 100
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                HStack {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(connected >= 50 ? Constants.Colors.green : Color.red)
                        // The 60 value is like a manually calculated padding space for the connectivity label to appear so it doesn't bleed off of the screen.
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
//            connected = ConnectivityManager.calcConnectivity(hikes: hikes)
        }
    }
}
