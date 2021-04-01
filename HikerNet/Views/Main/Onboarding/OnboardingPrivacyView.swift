
import SwiftUI
import SafariServices

struct OnboardingPrivacyView: View {
    @Binding var agreed: Bool
    @State private var showTerms = false
    @State private var showPrivacy = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Privacy")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 36))
            Text("You must agree to the HikerNet privacy policy and terms and conditions before you use the app.")
                .foregroundColor(.secondary)
                .font(Font.custom(Constants.Fonts.regular, size: 18))
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            HikerNetButton(title: "Privacy Policy", disabled: false) {
                showPrivacy = true
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .sheet(isPresented: $showPrivacy) {
                SafariView(url: URL(string: "\(Constants.apiUrl)/#/privacy")!)
            }

            HikerNetButton(title: "Terms and Conditions", disabled: false) {
                showTerms = true
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .sheet(isPresented: $showTerms) {
                SafariView(url: URL(string: "\(Constants.apiUrl)/#/terms")!)
            }
            
            Spacer()
            
            Toggle(isOn: $agreed) {
                Text("I agree to the privacy policy and terms and conditions")
                    .foregroundColor(.secondary)
                    .font(Font.custom(Constants.Fonts.regular, size: 18))
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 24, leading: 36, bottom: 0, trailing: 36))
    }
}

struct OnboardingPrivacy_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPrivacyView(agreed: .constant(true))
    }
}
