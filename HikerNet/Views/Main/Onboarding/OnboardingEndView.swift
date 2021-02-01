
import SwiftUI

struct OnboardingEndView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("MountainSignal")
                .resizable()
                .scaledToFit()
                .frame(width: 100, alignment: .center)
            Text("All set!\nLet's go!")
                .font(Font.custom(Constants.Fonts.medium, size: 48))
                .frame(maxWidth: .infinity, alignment: .leading)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(EdgeInsets(top: UIScreen.main.bounds.height * 0.2, leading: 36, bottom: 0, trailing: 36))
    }
}

struct OnboardingEnd_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingEndView()
    }
}
