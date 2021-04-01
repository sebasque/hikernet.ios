
import SwiftUI

struct SettingsView: View {
    @State private var showAbout = false
    @State private var showPrivacy = false
    @State private var showTerms = false
    @State private var cachedHikes = DatabaseManager.getHikes()
    @State private var showNotification: Bool = false
    @State private var notificationTitle: String = "ID Copied"
    let haptics = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Settings")
                .foregroundColor(.primary)
                .font(Font.custom(Constants.Fonts.medium, size: 28))
            SettingsButton(title: "About", image: "chevron.right") { showAbout = true }
            .sheet(isPresented: $showAbout) {
                SafariView(url: URL(string: "\(Constants.apiUrl)")!)
            }
            
            SettingsButton(title: "Privacy", image: "chevron.right") { showPrivacy = true }
            .sheet(isPresented: $showPrivacy) {
                SafariView(url: URL(string: "\(Constants.apiUrl)/#/privacy")!)
            }
            
            SettingsButton(title: "Terms and Conditions", image: "chevron.right") { showTerms = true }
            .sheet(isPresented: $showTerms) {
                SafariView(url: URL(string: "\(Constants.apiUrl)/#/terms")!)
            }
            
            SettingsButton(title: "Your ID: \(UserDefaultsManager.getId())", image: "doc.on.doc") {
                UIPasteboard.general.string = UserDefaultsManager.getId()
                haptics.impactOccurred()
                notificationTitle = "ID Copied"
                withAnimation { showNotification = true }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                    withAnimation { showNotification = false }
                })
            }
            if cachedHikes.count > 0 {
                SettingsButton(title: "\(cachedHikes.count) hike(s) cached", image: "square.and.arrow.down") {
                    haptics.impactOccurred()
                    do {
                        let hikes = DatabaseManager.getHikes()
                        let jsonData = try JSONEncoder().encode(hikes)
                        let jsonString = String(data: jsonData, encoding: .utf8)!
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd-MM-yyyy-HH-mm-ss"
                        let date = formatter.string(from: Date())
                        
                        let filename = getDocumentsDirectory().appendingPathComponent("hikernet-export-\(date).json")
                        try jsonString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
                        let av = UIActivityViewController(activityItems: [filename], applicationActivities: nil)
                        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
                    } catch {
                        print("Error saving file.")
                    }
                }
            }
            Spacer()
            VStack() {
                Text(notificationTitle)
                    .padding()
                    .frame(maxWidth: 140, maxHeight: 50)
                    .background(Color(UIColor.systemGray6))
                    .multilineTextAlignment(.center)
                    .cornerRadius(25)
                    .animation(.easeInOut)
                    .transition(.opacity)
                    .opacity(showNotification ? 1 : 0)
            }.frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(EdgeInsets(top: 24, leading: 24, bottom: 24, trailing: 24))
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .onAppear() {
            cachedHikes = DatabaseManager.getHikes()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
