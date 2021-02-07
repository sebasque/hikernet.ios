
import SwiftUI
import Mapbox

struct HikeDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var hike: HikeResponse
    @State var annotations = [MGLPointAnnotation]()
    
    var body: some View {
        ZStack {
            HikeMapView(annotations: $annotations)
                .ignoresSafeArea(.all, edges: .top)
            VStack {
                HStack {
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.primary)
                            .frame(width: 25, height: 20, alignment: .center)
                    }
                    .frame(width: 50, height: 50, alignment: .center)
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(25)
                    .shadow(radius: 5)
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
                MGLPointAnnotation(title: feature.serviceState, coordinate: CLLocationCoordinate2D(latitude: feature.lon, longitude: feature.lat))
            )
        }
    }
}
