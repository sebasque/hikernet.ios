
import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var onboardingDone: Bool

    var body: some View {
        if (onboardingDone) {
            HomeView()
        } else {
            OnboardingView(onboardingDone: $onboardingDone)
        }
    }

}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(onboardingDone: .constant(true)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
