
import SwiftUI

@main
struct HikerNetApp: App {
    let persistenceController = PersistenceController.shared
    @State var onboardingDone = UserDefaultsManager.getOnboardingDone()

    var body: some Scene {
        WindowGroup {
            MainView(onboardingDone: $onboardingDone)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
