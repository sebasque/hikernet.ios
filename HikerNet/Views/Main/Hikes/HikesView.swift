
import SwiftUI

// MARK: Main page for viewing hikes
struct HikesView: View {
    @Environment(\.colorScheme) private var colorScheme
    @State private var hikes = [HikeResponse]()
    @State private var totalDistance = 0.0
    @State private var totalTime = "00:00:00"
    @State private var downloading = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            if downloading {
                LottieView(name: "loading", play: $downloading, loop: true)
                    .frame(width: UIScreen.main.bounds.width, height: 200)
            } else {
                if hikes.count > 0 {
                    ScrollView(showsIndicators: true) {
                        VStack(alignment: .leading) {
                            Text("Your Hikes")
                                .foregroundColor(.primary)
                                .font(Font.custom(Constants.Fonts.medium, size: 28))
                            
                            HikeConnectivityView(hikes: hikes)
                                .padding(EdgeInsets(top: 8, leading: 0, bottom: 24, trailing: 0))
                            
                            HStack {
                                HStack(alignment: .center, spacing: 32) {
                                    VStack(alignment: .leading) {
                                        Text("\(hikes.count)")
                                            .foregroundColor(.primary)
                                            .font(Font.custom(Constants.Fonts.medium, size: 21))
                                        Text("hikes")
                                            .foregroundColor(.secondary)
                                            .font(Font.custom(Constants.Fonts.regular, size: 14))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(FormatManager.getDistance(distance: totalDistance))
                                            .foregroundColor(.primary)
                                            .font(Font.custom(Constants.Fonts.medium, size: 21))
                                        Text("distance")
                                            .foregroundColor(.secondary)
                                            .font(Font.custom(Constants.Fonts.regular, size: 14))
                                    }
                                    VStack(alignment: .leading) {
                                        Text(totalTime)
                                            .foregroundColor(.primary)
                                            .font(Font.custom(Constants.Fonts.medium, size: 21))
                                        Text("time")
                                            .foregroundColor(.secondary)
                                            .font(Font.custom(Constants.Fonts.regular, size: 14))
                                    }
                                }
                                Spacer()
                            }
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                            VStack(alignment: .leading) {
                                Text("Recent Activity")
                                    .foregroundColor(.primary)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                ForEach(hikes) { hike in
                                    NavigationLink(destination: HikeDetailView(hike: hike)) {
                                        HikeItemView(hike: hike)
                                            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                                    }
                                }
                            }
                            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
                        .ignoresSafeArea(.all, edges: .top)
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                } else {
                    VStack(alignment: .center, spacing: 16) {
                        if colorScheme == .dark {
                            LottieView(name: "smores-dark", play: .constant(true), loop: true)
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                        } else {
                            LottieView(name: "smores", play: .constant(true), loop: true)
                                .frame(width: UIScreen.main.bounds.width, height: 200)
                        }
                        Text(errorTitle)
                            .foregroundColor(.primary)
                            .font(Font.custom(Constants.Fonts.medium, size: 28))
                            .padding(EdgeInsets(top: 16, leading: 36, bottom: 0, trailing: 36))
                        Text(errorMessage)
                            .foregroundColor(.secondary)
                            .font(Font.custom(Constants.Fonts.regular, size: 18))
                            .multilineTextAlignment(.center)
                            .padding(EdgeInsets(top: 0, leading: 36, bottom: 0, trailing: 36))
                    }
                    .navigationBarHidden(true)
                    .navigationBarBackButtonHidden(true)
                }
            }
        }
        .statusBar(hidden: true)
        .background(Color(UIColor.systemBackground))
        .onAppear() {
            downloading = true
            if (!MeasureService.recording) {
                uploadHikes()
            } else {
                downloadHikes()
            }
        }
    }
    
    private func uploadHikes() {
        ApiManager.postHikes { res in
            switch res {
            case .success(let res):
                switch res {
                case .Success:
                    DatabaseManager.clearCache()
                case .Empty:
                    print("Database empty")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
            downloadHikes()
        }
    }
    
    private func downloadHikes() {
        ApiManager.getHikes { res in
            switch res {
            case .success(let data):
                if data.count < 1 {
                    errorTitle = "No Hikes"
                    errorMessage = "You haven't recorded any hikes. Start recording to see your data!"
                } else {
                    hikes = data.sorted(by: { (h1, h2) -> Bool in
                        let h1Start = FormatManager.getLocalDate(time: h1.start)
                        let h2Start = FormatManager.getLocalDate(time: h2.start)
                        return h1Start > h2Start
                    })
                    calcTotalDistance()
                    calcTotalTime()
                }
            case .failure(let err):
                switch err {
                case .RequestError:
                    errorTitle = "Request Error"
                    errorMessage = "We had a problem getting your hikes. Please try again later."
                case .ServerError:
                    errorTitle = "Server Error"
                    errorMessage = "Our servers are having some issues. Please try again later."
                case .ConnectionError:
                    errorTitle = "Connection Error"
                    errorMessage = "There was a problem with the connection. Make sure you're connected to the internet."
                }
            }
            downloading = false
        }
    }
    
    private func calcTotalDistance() {
        totalDistance = hikes.reduce(0, { (x, y) in
            x + y.distance
        })
    }
    
    private func calcTotalTime() {
        let total = hikes.reduce(0, { (x, y) in
            x + y.duration
        })
        totalTime = FormatManager.getStopWatchTime(elapsedSeconds: total)
    }

}

struct HikesView_Previews: PreviewProvider {
    static var previews: some View {
        HikesView()
    }
}
