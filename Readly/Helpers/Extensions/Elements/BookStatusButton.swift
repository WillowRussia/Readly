//
//  BookStatusButton.swift
//  Readly
//
//  Created by Илья Востров on 07.04.2025.
//
import SwiftUI

struct BookStatusButton: View {
    var status: BookStatus
    var action: () -> ()
    private var buttonText: String
    
    init (status: BookStatus, action: @escaping () -> Void) {
        self.status = status
        self.action = action
        
        switch status {
        case .read:
            buttonText = "Читаю"
        case .willRead:
            buttonText = "В планах"
        case .didRead:
            buttonText = "Прочитал"
        }
    }
        
    var body: some View {
        Button {
            action()
        } label: {
            Text(buttonText)
                .padding(.vertical, 3)
                .padding(.horizontal, 18)
                .font(type: .bold, size: 14)
                .foregroundStyle(.white)
                .background(buttohcolor())
                .clipShape(Capsule())
        }
    }
    
    func buttohcolor() -> Color {
        switch status {
        case .read:
            return Color.appRed
        case .willRead:
            return Color.appBlue
        case .didRead:
            return Color.appGreen
        }
    }
    
}
