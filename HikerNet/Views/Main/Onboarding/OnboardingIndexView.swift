
import SwiftUI

// MARK: Progress dots for onboarding
struct OnboardingIndexView: View {
    var numberOfPages: Int
    var currentIndex: Int
            
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<numberOfPages) { index in
              Circle()
                .fill(currentIndex >= index ? .primary : Color(UIColor.systemGray5))
                .frame(width: 8, height: 8)
                .transition(AnyTransition.opacity.combined(with: .scale))
                .id(index)
            }
        }
    }
}

struct OnboardingIndexView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingIndexView(numberOfPages: 5, currentIndex: 0)
    }
}
