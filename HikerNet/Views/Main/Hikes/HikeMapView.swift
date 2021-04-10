
import SwiftUI
import Mapbox

// MARK: Map view for hike details
struct HikeMapView: UIViewRepresentable {
    @Binding var annotations: [MGLPointAnnotation]
    private let mapView = MGLMapView(frame: .zero, styleURL: MGLStyle.outdoorsStyleURL)

    func makeUIView(context: UIViewRepresentableContext<HikeMapView>) -> MGLMapView {
        mapView.delegate = context.coordinator
        mapView.compassViewPosition = .bottomLeft
        return mapView
    }

    func updateUIView(_ uiView: MGLMapView, context: UIViewRepresentableContext<HikeMapView>) {
        updateAnnotations()
        if annotations.count > 0 {
            uiView.setCenter(
                CLLocationCoordinate2D(
                    latitude: annotations[0].coordinate.latitude,
                    longitude: annotations[0].coordinate.longitude
                ),
                zoomLevel: 14,
                direction: .zero,
                animated: true)
        }
    }
    
    func makeCoordinator() -> HikeMapView.Coordinator {
        Coordinator(self)
    }
    
    private func updateAnnotations() {
        if let currentAnnotations = mapView.annotations {
            mapView.removeAnnotations(currentAnnotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    final class Coordinator: NSObject, MGLMapViewDelegate {
        var control: HikeMapView

        init(_ control: HikeMapView) {
            self.control = control
        }
        
        func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            guard annotation is MGLPointAnnotation else {
                return nil
            }
            let reuseIdentifier = "\(annotation.coordinate.longitude)"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            if annotationView == nil {
                annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier)
                annotationView!.bounds = CGRect(x: 0, y: 0, width: 15, height: 15)
                annotationView!.backgroundColor = annotation.title == "1" ? UIColor(Constants.Colors.green) : .systemRed
            }
            return annotationView
        }
        
        class CustomAnnotationView: MGLAnnotationView {
            override func layoutSubviews() {
                super.layoutSubviews()
                layer.cornerRadius = bounds.width / 2
                layer.borderWidth = 1
                layer.borderColor = UIColor.systemBackground.cgColor
            }
        }
    }
}

extension MGLPointAnnotation {
    convenience init(title: String, coordinate: CLLocationCoordinate2D) {
        self.init()
        self.title = title
        self.coordinate = coordinate
    }
}
