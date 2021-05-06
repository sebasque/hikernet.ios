
import AVFoundation
import SwiftUI
import Mapbox

struct RecordView: View {
    @ObservedObject private var measureService = MeasureService.shared
    @State private var locationAuthorized = false
    @State private var locationButtonTapped = false
    @State private var showAlert = false
    
    private let haptics = UIImpactFeedbackGenerator(style: .medium)
    private let alertTitle = "Test in Progress"
    private let alertMessage = "We're still testing your connection. Wait a few more seconds and try again."

    var body: some View {
        ZStack {
            RecordMapView(
                currentLocation: CLLocationCoordinate2D(),
                firstTimeGettingLocation: true,
                locationButtonTapped: $locationButtonTapped,
                locationAuthorized: $locationAuthorized
            )
            .ignoresSafeArea(.all, edges: .top)
            .opacity(locationAuthorized ? 1 : 0)
            if locationAuthorized {
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .center) {
                                Text(FormatManager.getStopWatchTime(elapsedSeconds: Int(measureService.startTime.timeIntervalSinceNow.rounded() * -1)))
                                    .foregroundColor(.primary)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(MeasureService.recording ? 1.0 : 0.0)
                            }
                            ZStack(alignment: .center) {
                                Text(FormatManager.getDistance(distance: measureService.distance/1000))
                                    .foregroundColor(.primary)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(MeasureService.recording ? 1.0 : 0.0)
                            }
                            ZStack(alignment: .center) {
                                Image(systemName: "wifi")
                                    .foregroundColor(measureService.connected ? Constants.Colors.green : Color.red)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(MeasureService.recording ? 1.0 : 0.0)
                            }
                        }.padding()
                        Spacer()
                    }
                    Spacer()
                    ZStack {
                        Spacer()
                        RecordButton(title: !MeasureService.recording ? "START" : "STOP") {
                            if (!MeasureService.recording) {
                                measureService.startUpdates()
                                AudioServicesPlayAlertSound(SystemSoundID(1115))
                            } else {
                                if (!measureService.testInProgress) {
                                    measureService.stopUpdates()
                                    AudioServicesPlayAlertSound(SystemSoundID(1116))
                                } else {
                                    showAlert = true
                                }
                            }
                        }
                        CurrentLocationButton {
                            locationButtonTapped = true
                            haptics.impactOccurred()
                        }
                        .padding(EdgeInsets(top: 0, leading: 200, bottom: 0, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                }
            } else {
                VStack(alignment: .leading) {
                    Text("Permissions")
                        .foregroundColor(.primary)
                        .font(Font.custom(Constants.Fonts.medium, size: 28))
                    Text("Background location is needed for HikerNet to measure connectivity while your phone is locked. Change your location setting to 'Always' to enable background location.")
                        .foregroundColor(.secondary)
                        .font(Font.custom(Constants.Fonts.regular, size: 18))
                        .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
                    HikerNetButton(title: "Enable Location", disabled: false) {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
