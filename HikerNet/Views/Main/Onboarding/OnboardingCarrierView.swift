
import SwiftUI
import CoreTelephony

struct OnboardingCarrierView: View {
    @Binding var carrierRetrieved: Bool
    @State private var showingAlert: Bool = false
    @State private var notificationTitle: String = "Your carrier: "
    @State private var showNotification: Bool = false
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Carrier")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 36))
            Text("We need your carrier info to see which cellular providers have certain connectivity. We only store the name of your provider (e.g. Verizon).")
                .foregroundColor(.secondary)
                .font(Font.custom(Constants.Fonts.regular, size: 18))
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                HikerNetButton(title: "Get Carrier", disabled: carrierRetrieved) {
                    haptics.impactOccurred()
                    getCarrier()
                }.disabled(carrierRetrieved)
                LottieView(name: "checkmark", play: $carrierRetrieved, loop: false)
                    .frame(width: 75, height: 75)
                    .opacity(carrierRetrieved ? 1 : 0)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Could not retrieve your carrier. Please make sure you have a valid SIM card, your cellular plan is active, and you are connected to the Internet."), dismissButton: .default(Text("Ok")))
            }
            
            Spacer()
            VStack() {
                Text(notificationTitle)
                    .padding()
                    .frame(maxHeight: 50)
                    .background(Color(UIColor.systemGray6))
                    .multilineTextAlignment(.center)
                    .cornerRadius(25)
                    .animation(.easeInOut)
                    .transition(.opacity)
                    .opacity(showNotification ? 1 : 0)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 24, leading: 36, bottom: 0, trailing: 36))
    }
    
    private func getCarrier() {
        let networkInfo = CTTelephonyNetworkInfo()
        var carriers: [String] = []
        
        guard let carrierInfo = networkInfo.serviceSubscriberCellularProviders else {
            showingAlert = true
            return
        }
        
        for obj in carrierInfo {
            let carrier = obj.value.carrierName
            if (carrier != nil) {
                carriers.append(carrier!)
            }
        }
        
        if (carriers.count == 1) {
            notificationTitle = "Your carrier: \(carriers[0])"
            withAnimation { showNotification = true }
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                withAnimation { showNotification = false }
            }
            UserDefaultsManager.setCarrier(carrier: carriers[0])
            carrierRetrieved = true
        } else {
            showingAlert = true
        }
    }
}

struct OnboardingCarrier_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCarrierView(carrierRetrieved: .constant(true))
    }
}
