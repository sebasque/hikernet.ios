
import SwiftUI
import Mapbox

// MARK: Page for viewing connectivity of a hike and details
struct HikeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var hike: HikeResponse
    @State private var annotations = [MGLPointAnnotation]()
    
    var body: some View {
        ZStack {
            HikeMapView(annotations: $annotations)
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                HStack {
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        ZStack {
                            Circle()
                                .fill(Color(UIColor.systemBackground))
                                .frame(width: 50, height: 50, alignment: .center)
                                .cornerRadius(25)
                                .shadow(radius: 5)
                            Image(systemName: "arrow.left")
                                .resizable()
                                .foregroundColor(.primary)
                                .frame(width: 25, height: 20, alignment: .center)
                        }
                    }
                    Spacer()
                }.padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 0))
                Spacer()
            }
            HikeCardView(hike: hike)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear() {
            makeAnnotations()
        }
    }
    
    private func makeAnnotations() {
        for feature in hike.features {
            annotations.append(
                MGLPointAnnotation(title: "\(feature.http)", coordinate: CLLocationCoordinate2D(latitude: feature.lat, longitude: feature.lon))
            )
        }
    }
}
