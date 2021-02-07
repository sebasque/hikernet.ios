
import SwiftUI

struct OnboardingIdView: View {
    @Binding var idRetrieved: Bool
    @State var showingAlert: Bool = false
    @State var alertMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Your ID")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 36))
            Text("You need to register an ID before you can start hiking. We use this to keep track of your hikes without knowing who you are.")
                .foregroundColor(.secondary)
                .font(Font.custom(Constants.Fonts.regular, size: 18))
                .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                HikerNetButton(title: "Get ID", disabled: idRetrieved) {
                    ApiManager.getId { (id) in
                        switch (id) {
                        case "server":
                            alertMessage = "There was problem with our servers. Please try again later."
                            showingAlert = true
                        case "connection":
                            alertMessage = "You don't seem to have an internet connection. Please try again later."
                            showingAlert = true
                        default:
                            UserDefaultsManager.setId(id: id)
                            idRetrieved = true
                        }
                    }
                }
                LottieView(name: "checkmark", play: $idRetrieved, loop: false)
                    .frame(width: 75, height: 75)
                    .opacity(idRetrieved ? 1 : 0)
            }
            .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 24, leading: 36, bottom: 0, trailing: 36))

    }
}

struct OnboardingId_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIdView(idRetrieved: .constant(false))
    }
}
