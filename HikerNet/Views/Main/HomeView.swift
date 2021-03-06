
import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            HikesView()
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Hikes")
                }
            RecordView()
                .tabItem {
                    Image(systemName: "record.circle")
                    Text("Record")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
        .accentColor(Constants.Colors.green)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let standardAppearance = UITabBarAppearance()
        standardAppearance.backgroundColor = .systemBackground
        standardAppearance.shadowColor = .systemBackground
        standardAppearance.stackedItemPositioning = .centered
        standardAppearance.stackedItemSpacing = 65
        standardAppearance.stackedItemWidth = 50
        tabBar.standardAppearance = standardAppearance
    }
}
