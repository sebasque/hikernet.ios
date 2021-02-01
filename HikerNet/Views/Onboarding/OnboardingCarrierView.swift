
import SwiftUI
import CoreTelephony

struct OnboardingCarrierView: View {
    @Binding var carrierRetrieved: Bool
    @State var showingAlert: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Carrier")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 36))
            Text("We need your carrier info to see which cellular provider have certain connectivity. All we'll store is the name of your provider (i.e. Verizon).")
                .foregroundColor(.secondary)
                .font(Font.custom(Constants.Fonts.regular, size: 18))
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                HikerNetButton(title: "Get Carrier", disabled: carrierRetrieved) {
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
