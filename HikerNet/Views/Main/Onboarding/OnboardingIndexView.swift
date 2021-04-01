
import SwiftUI

struct OnboardingIndexView: View {
    let numberOfPages: Int
    let currentIndex: Int
        
    private let circleSize: CGFloat = 8
    private let circleSpacing: CGFloat = 12
    private let primaryColor = Color(UIColor.label)
    private let secondaryColor = Color(UIColor.systemGray5)
    
    var body: some View {
        HStack(spacing: circleSpacing) {
            ForEach(0..<numberOfPages) { index in
              Circle()
                .fill(currentIndex >= index ? primaryColor : secondaryColor)
                .frame(width: circleSize, height: circleSize)
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
