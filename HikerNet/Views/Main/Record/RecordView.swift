
import AVFoundation
import SwiftUI
import Mapbox

struct RecordView: View {
    @ObservedObject var measureService = MeasureService()
    @State var backgroundLocationAuthorized: Bool = false
    @State var currentLocationButtonTapped: Bool = false
    @State var showingTestInProgressAlert: Bool = false
    
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    let testInProgressTitle = "Test in Progress"
    let testInProgressMessage = "We're still testing your connection. Wait a few more seconds and try again."

    var body: some View {
        ZStack {
            RecordMapView(
                currentLocation: CLLocationCoordinate2D(),
                firstTimeGettingLocation: true,
                currentLocationButtonTapped: $currentLocationButtonTapped,
                backgroundLocationAuthorized: $backgroundLocationAuthorized
            )
            .ignoresSafeArea(.all, edges: .top)
            .opacity(backgroundLocationAuthorized ? 1 : 0)
            if backgroundLocationAuthorized {
                VStack {
                    HStack(alignment: .center) {
                        VStack(alignment: .leading) {
                            ZStack(alignment: .center) {
                                Text(TimeFormatter.getStopWatchTime(elapsedSeconds: Int(measureService.startTime.timeIntervalSinceNow.rounded() * -1)))
                                    .foregroundColor(.primary)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(measureService.recording ? 1.0 : 0.0)
                            }
                            ZStack(alignment: .center) {
                                Text(String(format: "%.2f", measureService.distance/1000) + " km")
                                    .foregroundColor(.primary)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(measureService.recording ? 1.0 : 0.0)
                            }
                            ZStack(alignment: .center) {
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                    .foregroundColor(measureService.inService ? Constants.Colors.green : Color.red)
                                    .font(Font.custom(Constants.Fonts.medium, size: 28))
                                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                                    .background(
                                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                                            .fill(Color(UIColor.systemBackground))
                                            .shadow(radius: 5)
                                            .frame(minHeight: 50)
                                    )
                                    .opacity(measureService.recording ? 1.0 : 0.0)
                            }
                        }.padding()
                        Spacer()
                    }
                    
                    Spacer()
                    ZStack {
                        Spacer()
                        RecordButton(title: !measureService.recording ? "START" : "STOP") {
                            if (!measureService.recording) {
                                measureService.startUpdates()
                                AudioServicesPlayAlertSound(SystemSoundID(1115))
                            } else {
                                if (!measureService.saveInProgress) {
                                    measureService.stopUpdates()
                                    AudioServicesPlayAlertSound(SystemSoundID(1116))
                                } else {
                                    showingTestInProgressAlert = true
                                }
                            }
                        }
                        CurrentLocationButton {
                            currentLocationButtonTapped = true
                            haptics.impactOccurred()
                        }
                        .padding(EdgeInsets(top: 0, leading: 200, bottom: 0, trailing: 0))
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 24, trailing: 0))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .alert(isPresented: $showingTestInProgressAlert) {
                    Alert(title: Text(testInProgressTitle), message: Text(testInProgressMessage), dismissButton: .default(Text("Ok")))
                }
            } else {
                VStack(alignment: .leading) {
                    Text("Background Location Needed")
                        .foregroundColor(.primary)
                        .font(Font.custom(Constants.Fonts.medium, size: 36))
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
                .padding(EdgeInsets(top: 24, leading: 36, bottom: 0, trailing: 36))
            }
        }
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
