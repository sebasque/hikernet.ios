//
//  RecordButton.swift
//  HikerNet
//
//  Created by Michael Koohang on 1/31/21.
//

import SwiftUI

struct RecordButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Constants.Colors.green)
                .font(Font.custom(Constants.Fonts.semibold, size: 24))
        }
        .frame(width: 100, height: 100, alignment: .center)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(30)
        .shadow(radius: 5)
    }
}

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordButton(title: "START", action: {return})
            .previewLayout(.sizeThatFits)
    }
}
