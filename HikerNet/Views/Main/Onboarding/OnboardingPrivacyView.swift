
import SwiftUI
import SafariServices

struct OnboardingPrivacyView: View {
    @Binding var privacyAgreed: Bool
    @State private var showPolicy = false
    @State private var url = URL(string: "\(Constants.apiUrl)/#/privacy")!
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Privacy")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 36))
            Text("You must agree to the HikerNet privacy policy before you use the app.")
                .foregroundColor(.secondary)
                .font(Font.custom(Constants.Fonts.regular, size: 18))
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            HikerNetButton(title: "View Policy", disabled: false) {
                showPolicy = true
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            
            Spacer()
            
            Toggle(isOn: $privacyAgreed) {
                Text("I agree to the privacy policy")
                    .foregroundColor(.secondary)
                    .font(Font.custom(Constants.Fonts.regular, size: 18))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 24, leading: 36, bottom: 0, trailing: 36))
        .sheet(isPresented: $showPolicy, content: {
            SafariView(url: url)
        })
    }
}



struct OnboardingPrivacy_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPrivacyView(privacyAgreed: .constant(true))
    }
}
