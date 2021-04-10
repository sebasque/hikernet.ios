
import SwiftUI

// MARK: Connectivity bar showing how connected a certain hike is
struct HikeConnectivityView: View {
    @State var hikes: [HikeResponse]
    @State private var connectivity = 100
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Color.red)
                        .frame(width: geometry.size.width, height: 10)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(Constants.Colors.green)
                        .frame(width: geometry.size.width * CGFloat(connectivity) / 100 , height: 10)
                }
                HStack(alignment: .center) {
                    Text("connectivity")
                        .foregroundColor(.secondary)
                        .font(Font.custom(Constants.Fonts.regular, size: 14))
                    Spacer()
                    Text("\(connectivity)%")
                        .font(Font.custom(Constants.Fonts.medium, size: 17))
                        .foregroundColor(connectivity >= 50 ? Constants.Colors.green : Color.red)
                }
            }
        }
        .onAppear() {
            connectivity = ConnectivityManager.calcConnectivity(hikes: hikes)
        }
    }
}

struct HikeConnectivityView_Previews: PreviewProvider {
    static var previews: some View {
        HikeConnectivityView(hikes: [])
    }
}
