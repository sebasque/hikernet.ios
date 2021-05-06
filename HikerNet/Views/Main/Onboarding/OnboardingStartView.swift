
import SwiftUI

// MARK: Onboarding start page
struct OnboardingStartView: View {
    private let deviceHeight = UIScreen.main.bounds.height
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("MountainSignal")
                .resizable()
                .scaledToFit()
                .frame(width: 100, alignment: .center)
            Text("Welcome to HikerNet")
                .font(Font.custom(Constants.Fonts.medium, size: 48))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: deviceHeight * 0.3, leading: 36, bottom: 0, trailing: 36))
    }
}

struct OnboardingStart_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStartView()
    }
}
