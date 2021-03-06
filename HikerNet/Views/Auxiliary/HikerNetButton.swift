
import SwiftUI

// MARK: Standard button for HikerNet
struct HikerNetButton: View {
    var title: String
    var disabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .padding()
                .background(disabled ? Color(UIColor.systemGray3) : Constants.Colors.green)
                .foregroundColor(.white)
                .font(Font.custom(Constants.Fonts.semibold, size: 18))
                .cornerRadius(15)
        }
        .disabled(disabled)
        .frame(height: 50)
    }
}

struct HikerNetButton_Previews: PreviewProvider {
    static var previews: some View {
        HikerNetButton(title: "Get ID", disabled: false, action: {return})
    }
}
