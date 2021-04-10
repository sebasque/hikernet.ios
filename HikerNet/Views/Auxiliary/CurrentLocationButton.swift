
import SwiftUI

// MARK: Current location button for MapView
struct CurrentLocationButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "location")
                .resizable()
                .foregroundColor(Constants.Colors.green)
                .frame(width: 25, height: 25, alignment: .center)
        }
        .frame(width: 50, height: 50, alignment: .center)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

struct CurrentLocationButton_Previews: PreviewProvider {
    static var previews: some View {
        CurrentLocationButton(action: {return})
    }
}
