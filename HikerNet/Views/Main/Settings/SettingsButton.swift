
import SwiftUI

// MARK: Standard UI button for settings page
struct SettingsButton: View {
    @State var title: String
    @State var image: String
    @State var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(alignment: .center) {
                Text(title)
                    .foregroundColor(.primary)
                    .font(Font.custom(Constants.Fonts.medium, size: 17))
                Spacer()
                Image(systemName: image)
                    .foregroundColor(Constants.Colors.green)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, minHeight: 60)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(15)
    }
}

struct SettingsButton_Previews: PreviewProvider {
    static var previews: some View {
        SettingsButton(title: "About", image: "info.circle", action: {return})
    }
}
